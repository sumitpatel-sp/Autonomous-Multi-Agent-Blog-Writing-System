# ✍️ LangGraph Blog Writer Agent

An automated, AI-powered blog writing assistant built with **LangGraph**, **Streamlit**, and **OpenRouter**. 

This application uses a multi-agent workflow to research topics, generate structured outlines, write comprehensive sections concurrently, and even generate contextual images using Google's Gemini. It packages the final output into a clean, downloadable Markdown file and ZIP bundle.

---

## ✨ Features

* **Multi-Agent Architecture:** Utilizes LangGraph to orchestrate specialized nodes (Router, Researcher, Orchestrator, Worker, Reducer).
* **Dynamic Web Research:** Integrates with Tavily to fetch real-time, up-to-date information for your articles.
* **OpenRouter Support:** Swap LLMs easily via OpenRouter (defaults to `openai/gpt-4o-mini`).
* **Automated Image Generation:** Uses Google GenAI (Gemini 2.5 Flash) to generate relevant technical diagrams and blog images.
* **Interactive UI:** A sleek Streamlit frontend that streams the agent's thought process, renders Markdown with local images, and provides download links.
* **Smart Bundling:** Downloads the final Markdown and generated images in a neat `.zip` package.

---

## 🛠️ Tech Stack

* **Language:** Python 3.9+
* **Framework:** [LangGraph](https://python.langchain.com/v0.1/docs/langgraph/) & [LangChain](https://python.langchain.com/)
* **Frontend:** [Streamlit](https://streamlit.io/)
* **LLM Gateway:** [OpenRouter](https://openrouter.ai/)
* **Search/Research:** [Tavily](https://tavily.com/)
* **Image Generation:** [Google GenAI](https://aistudio.google.com/)

---

## 🚀 Getting Started

### 1. Clone the Repository
```bash
git clone https://github.com/sumitpatel-sp/Autonomous-Multi-Agent-Blog-Writing-System.git
cd Autonomous-Multi-Agent-Blog-Writing-System
```
