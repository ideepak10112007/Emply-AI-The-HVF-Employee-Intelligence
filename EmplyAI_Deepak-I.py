import streamlit as st
import requests
import json
import mysql.connector
import pandas as pd
import re

# ============================================================
#  1. DATABASE CONFIGURATION
# ============================================================
def get_db_connection():
    try:
        return mysql.connector.connect(
            host="localhost",
            user="root",
            password="",
            database="emply_db"
        )
    except Exception:
        return None


# ============================================================
#  2. OLLAMA CONFIGURATION  — swap model name here only
# ============================================================
OLLAMA_HOST = "http://localhost:11434"
MODEL_NAME  = "llama3.2:3b-instruct-q4_K_M"   


# ============================================================
#  3. PAGE CONFIG & STYLING
# ============================================================
st.set_page_config(
    page_title="Emply — HVF Employee Intelligence",
    page_icon="🛡️",
    layout="wide"
)

st.markdown("""
<style>
/* ── Chat bubbles ─────────────────────────────────────── */
.stChatMessage {
    border-radius: 10px;
    margin-bottom: 14px;
    border-left: 3px solid #00c9a7;
    background-color: var(--secondary-background-color);
    color: var(--text-color);
    padding: 4px 8px;
}

/* ── Sidebar tweaks ───────────────────────────────────── */
section[data-testid="stSidebar"] { min-width: 240px !important; }

/* ── Expander table ───────────────────────────────────── */
.stTable { font-size: 0.85rem; }
</style>
""", unsafe_allow_html=True)


# ============================================================
#  4. SECURE LOGIN
# ============================================================
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False

def login():
    st.markdown("<h2 style='text-align:center;'>🛡️ HVF Central Intelligence Terminal 🪖</h2>", unsafe_allow_html=True)
    _, col, _ = st.columns([1, 1.2, 1])
    with col:
        with st.form("login_form"):
            u = st.text_input("Authorization ID")
            p = st.text_input("Passcode", type="password")
            submitted = st.form_submit_button("Engage System", use_container_width=True)
            if submitted:
                if u == "admin" and p == "hvf123":
                    st.session_state.logged_in = True
                    st.rerun()
                else:
                    st.error("Access Denied.")

if not st.session_state.logged_in:
    login()
    st.stop()


# ============================================================
#  5. SIDEBAR
# ============================================================
st.sidebar.title("🌐 Emply Prime_v4")
st.sidebar.caption("HVF AI Agent  |  System Status: **Online**")
st.sidebar.divider()

if st.sidebar.button("🗑️  Clear Conversation", use_container_width=True):
    st.session_state.messages = []
    st.rerun()

if st.sidebar.button("🔌  Lock System", use_container_width=True):
    st.session_state.logged_in = False
    st.rerun()

st.sidebar.divider()
st.sidebar.caption("DB: `emply_db @ localhost`")


# ============================================================
#  6. HEADER
# ============================================================
st.title("💬 Emply — The HVF Employee Intelligence")
st.caption("Ask me anything: Employee records, HVF history, Tank specs, Science, Code — or just say Hi.")

if "messages" not in st.session_state:
    st.session_state.messages = []


# ============================================================
#  7. KNOWLEDGE BASE  (single source of truth injected everywhere)
# ============================================================
HVF_KNOWLEDGE = """
=== HVF FACTUAL KNOWLEDGE (DO NOT HALLUCINATE BEYOND THIS) ===
- HVF = Heavy Vehicles Factory, Avadi, Chennai, Tamil Nadu, India.
- Operates under Armoured Vehicles Nigam Limited (AVNL), Ministry of Defence, Government of India.
- Manufactures India's Main Battle Tanks: T-90 Bhishma and Arjun MBT.

=== DATABASE SCHEMA ===
Table: sections       -> section_id, section_name, employee_count
Table: employees      -> emp_id, emp_code, name, designation, section_id, salary, blood_group
Table: attendance     -> att_id, emp_id, work_date, status ('Present'/'Absent'/'Leave')
Table: employee_leaves-> leave_id, emp_id, leave_type, status

=== SECTION / DESIGNATION MAPPINGS ===
'SMS' or 'Steel Metal Shop'              -> section_name = 'SMS'
'ITC' or 'Information Technology Center' -> section_name = 'I.T.C'
'JWM' or 'Joint Working Manager'         -> designation  = 'JWM'
"""


# ============================================================
#  8. SYSTEM PROMPTS
# ============================================================

# ── 8A. INTENT CLASSIFIER ───────────────────────────────────
CLASSIFIER_PROMPT = f"""
You are a strict intent classifier. Your ONLY job is to output exactly one word.

Rules:
- Output DATABASE  → if the user is asking for records, names, lists, counts, salaries,
  blood groups, attendance, leaves, sections, designations, or anything that needs the DB.
- Output GENERAL   → for greetings (hi/hello/hey/thanks/bye), HVF history, tank specs,
  science, coding, math, or any non-data question.

Do NOT output anything else. One word. No punctuation. No explanation.
"""

# ── 8B. SQL GENERATOR ───────────────────────────────────────
SQL_GENERATOR_PROMPT = f"""
You are an expert MySQL query writer. Convert natural language to a single valid MySQL SELECT query.

{HVF_KNOWLEDGE}

STRICT RULES:
1. Output ONLY the raw SQL query. No markdown, no backticks, no code fences, no explanation.
2. Always start with SELECT.
3. For any name/section/designation text filter use LIKE with wildcards:
   e.g.  WHERE e.name LIKE '%iyappan%'
4. Join tables using proper ON clauses:
   employees e JOIN sections s ON e.section_id = s.section_id
   employees e JOIN attendance a ON e.emp_id = a.emp_id
   employees e JOIN employee_leaves el ON e.emp_id = el.emp_id
5. Tolerate typos: 'blod grop'→blood_group, 'salarie/pay'→salary,
   'presnt/absnt'→status, 'leeve'→leave_type
6. If no specific section/employee is mentioned and the user asks for a list/roster,
   return ALL employees with relevant columns.
7. For attendance: if no date given, return the most recent records.
8. Never use LIMIT unless user asks for top-N.
9. For counting: use COUNT(*) with GROUP BY.
10. If the question is truly unanswerable by SQL, output exactly: CANNOT_GENERATE
"""

# ── 8C. ANSWER GENERATOR ────────────────────────────────────
ANSWER_PROMPT = f"""
You are Emply, the intelligent AI assistant for the Heavy Vehicles Factory (HVF), Avadi.
Your personality: elite, precise, professional, and direct.

{HVF_KNOWLEDGE}

=== RESPONSE LENGTH RULES (follow these strictly) ===

GREETINGS (hi / hello / hey / good morning / thanks / bye):
→ Max 35 words. Introduce yourself as Emply, HVF's AI assistant. Nothing else. DO NOT mention sections, tables, or capabilities unprompted.

SIMPLE FACTUAL (one-liner answers: "what is HVF?", "what is T-90?", counts, single values):
→ 30–60 words. Clear, sharp, no padding.

MODERATE QUERIES (attendance summary, department info, multi-row DB results, general explanations):
→ 60–120 words. Structured. Use bullet points only if listing multiple items.

COMPLEX / ANALYTICAL (full rosters, multi-table analysis, coding help, detailed technical questions):
→ 120–250 words max. Well-structured with headers if needed. Bullet points for lists.

CRITICAL:
- Never pad answers with filler phrases like "Certainly!", "Of course!", "Great question!"
- Never mention what sections/tables exist unless the user asks.
- Never fabricate employee data or HVF facts not in the knowledge base.
- For DB summaries: present data cleanly; do not re-invent numbers already shown in the table.
"""


# ============================================================
#  9. HELPER  — call Ollama (no streaming, reliable)
# ============================================================
def ollama_chat(system: str, messages: list, stream: bool = False) -> str:
    payload = {
        "model": MODEL_NAME,
        "messages": [{"role": "system", "content": system}] + messages,
        "stream": stream,
        "options": {"temperature": 0.3, "top_p": 0.9}
    }
    try:
        resp = requests.post(f"{OLLAMA_HOST}/api/chat", json=payload, timeout=120)
        resp.raise_for_status()
        return resp.json()["message"]["content"].strip()
    except Exception as e:
        return f"__ERROR__: {e}"


def ollama_stream(system: str, messages: list):
    """Yields text chunks for streaming display."""
    payload = {
        "model": MODEL_NAME,
        "messages": [{"role": "system", "content": system}] + messages,
        "stream": True,
        "options": {"temperature": 0.3, "top_p": 0.9}
    }
    try:
        with requests.post(f"{OLLAMA_HOST}/api/chat", json=payload,
                           stream=True, timeout=120) as resp:
            for line in resp.iter_lines():
                if line:
                    chunk = json.loads(line)
                    token = chunk.get("message", {}).get("content", "")
                    if token:
                        yield token
                    if chunk.get("done"):
                        break
    except Exception as e:
        yield f"\n\n⚠️ Stream error: {e}"


def clean_sql(raw: str) -> str:
    """Strip markdown fences, backticks, leading text from SQL output."""
    cleaned = re.sub(r"```sql|```", "", raw, flags=re.IGNORECASE).strip()
    cleaned = cleaned.replace("`", "").strip()
    # If model output has explanation text before SELECT, extract from SELECT onward
    match = re.search(r"(SELECT\s.+)", cleaned, re.IGNORECASE | re.DOTALL)
    return match.group(1).strip() if match else cleaned


# ============================================================
#  10. DISPLAY EXISTING CHAT HISTORY
# ============================================================
for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])
        if msg.get("dataframe") is not None:
            with st.expander("📊 Raw Database Records"):
                st.dataframe(msg["dataframe"], use_container_width=True)


# ============================================================
#  11. MAIN CHAT LOGIC
# ============================================================
if user_input := st.chat_input("Type your query here..."):

    # Append & show user message
    st.session_state.messages.append({"role": "user", "content": user_input})
    with st.chat_message("user"):
        st.markdown(user_input)

    with st.chat_message("assistant"):
        final_answer = ""
        df_result    = None

        try:
            # ── STEP 1: Classify intent ──────────────────────────
            intent_raw = ollama_chat(
                CLASSIFIER_PROMPT,
                [{"role": "user", "content": user_input}]
            )
            intent = "DATABASE" if "DATABASE" in intent_raw.upper() else "GENERAL"

            # ── STEP 2: Database path ────────────────────────────
            if intent == "DATABASE":
                sql_raw = ollama_chat(
                    SQL_GENERATOR_PROMPT,
                    [{"role": "user", "content": user_input}]
                )

                if "CANNOT_GENERATE" in sql_raw.upper() or sql_raw.startswith("__ERROR__"):
                    intent = "GENERAL"   # fall through to general

                else:
                    query = clean_sql(sql_raw)

                    db_ok   = False
                    db_error = None
                    try:
                        conn = get_db_connection()
                        if conn:
                            df_result = pd.read_sql(query, conn)
                            conn.close()
                            db_ok = True
                        else:
                            st.error("🚨 Database connection failed. Check XAMPP / MySQL.")
                    except Exception as sql_err:
                        db_error = str(sql_err)
                        db_ok    = False

                    if db_ok and df_result is not None and not df_result.empty:
                        # Stream the natural-language summary
                        summary_messages = [{
                            "role": "user",
                            "content": (
                                f"The user asked: \"{user_input}\"\n"
                                f"The database returned {len(df_result)} record(s):\n"
                                f"{df_result.to_dict('records')}\n\n"
                                "Summarize this data professionally and concisely. "
                                "Do NOT re-list every single row if there are many — give a clear overview."
                            )
                        }]
                        placeholder = st.empty()
                        streamed = ""
                        for token in ollama_stream(ANSWER_PROMPT, summary_messages):
                            streamed += token
                            placeholder.markdown(streamed + "▌")
                        placeholder.markdown(streamed)
                        final_answer = streamed

                        with st.expander("📊 Raw Database Records"):
                            st.dataframe(df_result, use_container_width=True)

                    elif db_ok and df_result is not None and df_result.empty:
                        # SQL ran fine but zero rows — answer gracefully
                        no_data_msg = [{
                            "role": "user",
                            "content": (
                                f"The user asked: \"{user_input}\"\n"
                                "The SQL query ran successfully but returned zero records. "
                                "Inform the user politely that no matching records were found."
                            )
                        }]
                        placeholder = st.empty()
                        streamed = ""
                        for token in ollama_stream(ANSWER_PROMPT, no_data_msg):
                            streamed += token
                            placeholder.markdown(streamed + "▌")
                        placeholder.markdown(streamed)
                        final_answer = streamed

                    elif db_error:
                        # SQL was malformed — fall back to general
                        intent = "GENERAL"

            # ── STEP 3: General path ─────────────────────────────
            if intent == "GENERAL" or not final_answer:
                # Build a short context window (last 6 turns)
                history = []
                for m in st.session_state.messages[-6:]:
                    history.append({"role": m["role"], "content": m["content"]})

                placeholder = st.empty()
                streamed = ""
                for token in ollama_stream(ANSWER_PROMPT, history):
                    streamed += token
                    placeholder.markdown(streamed + "▌")
                placeholder.markdown(streamed)
                final_answer = streamed

        except Exception as fatal:
            final_answer = f"⚠️ System fault: {fatal}"
            st.error(final_answer)

    # ── Save to session memory ───────────────────────────────
    if final_answer:
        st.session_state.messages.append({
            "role":      "assistant",
            "content":   final_answer,
            "dataframe": df_result
        })