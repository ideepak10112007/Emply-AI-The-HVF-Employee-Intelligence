```markdown
 🛡️ Emply - The HVF Employee Intelligence 🪖

An enterprise-grade, secure offline AI assistant engineered specifically for the **Heavy Vehicles Factory (HVF) in Avadi, Chennai**, operating under Armoured Vehicles Nigam Limited (AVNL), Ministry of Defence, Government of India. 

Emply features a cutting-edge **dual-brain routing architecture** that dynamically processes natural language inputs to either execute real-time local MySQL database queries or provide comprehensive, domain-specific defense engineering insights.

---

 🚀 Key Features

* **Secure Authentication Portal:** A hard-coded terminal-style login gate protecting internal data structures from unauthorized perimeter access.
* **Dual-Brain Intelligent Router:** A low-latency classification algorithm that determines if a user inquiry requires data extraction (`DATABASE`) or conceptual analysis (`GENERAL`).
* **Deterministic SQL Compiler:** Seamlessly translates complex, ungrammatical, or "floppy" human questions into precise MySQL code blocks using advanced wildcard `LIKE` logic and implicit typo correction.
* **Adaptive Visual Theme Mapping:** Custom CSS injectors override native components to guarantee flawless conversation text visibility across both Streamlit Light and Dark modes.
* **Localized Factory Lore:** Hardcoded semantic translation maps for unique factory structures (e.g., matching "Steel Metal Shop" to the literal database string `'SMS'`).

---

 🛠️ Tech Stack

* **User Interface:** Streamlit (Python-based Web Framework)
* **Database Management:** MySQL Relational Database Server
* **Local Inference Engine:** Ollama (Fully Air-Gapped / Offline Deployment)
* **Core Neural Network Model:** `llama3.2:3b` (Highly optimized for complex instruction following and automated SQL generation)

---

 📊 Database Schema Architecture

The database tracks tracking parameters across a 100-employee roster distributed throughout 6 primary shop environments:

* **`sections`** (`section_id`, `section_name`, `employee_count`)
    * *Supported Shops:* 'SMS' (Steel Metal Shop), 'Hull Shop', 'Die Shop', 'Engine Shop', 'Assembly Shop', 'I.T.C' (Information Technology Center).
* **`employees`** (`emp_id`, `emp_code`, `name`, `designation`, `section_id`, `salary`, `blood_group`)
* **`attendance`** (`att_id`, `emp_id`, `work_date`, `status`)
* **`employee_leaves`** (`leave_id`, `emp_id`, `leave_type`, `status`)

---

 💻 Installation & Local Deployment Guide

Follow these sequential steps to run this secure terminal environment on your local workstation:

### 1. Clone the Repository
```bash
git clone [https://github.com/ideepak10112007/Emply-AI-The-HVF-Employee-Intelligence.git](https://github.com/ideepak10112007/Emply-AI-The-HVF-Employee-Intelligence.git)
cd Emply-AI-The-HVF-Employee-Intelligence

```

### 2. Configure the Offline LLM Environment

Ensure Ollama is installed on your host machine, then pull the required model layer via your command terminal:

```bash
ollama pull llama3.2:3b

```

### 3. Initialize the Relational Database

Set up your local MySQL Server instance and populate the relational tables with your data. Ensure the database credentials match the connection metrics specified inside the main application code.

### 4. Install Dependencies & Launch

Install the required application layers using pip, then deploy the server architecture:

```bash
pip install streamlit mysql-connector-python requests
python -m streamlit run EmplyAI_Deepak-I.py

```

---

## 🔒 Security & Access Disclaimer

> **NOTICE:** This system is configured strictly for internal administrative evaluation. All access points are subject to secure session logging. Unauthorized modifications of database records, credentials, or code routing files are heavily restricted.

```

```
