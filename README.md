# MCP Tab Control

Welcome to the official support hub for **MCP Tab Control**.

This repository is dedicated to community discussions, feature requests, and bug reporting.

## 📥 Installation

MCP Tab Control requires two pieces to function: a background system daemon and a Chrome Extension.

### 1. Install the Daemon (macOS/Linux)
Open your terminal and run the following command to download and install the background router:

```bash
curl -fsSL https://raw.githubusercontent.com/tabctrl-io/tabctrl-io/main/scripts/install.sh | bash
```
Once installed, start the background service:
```bash
mcp-tab-control start
```

### 2. Connect Your AI Agent
Add the stateless tool configuration to your AI agent's configuration file:
```json
{
  "mcpServers": {
    "mcp-tab-control": {
      "command": "mcp-tab-control",
      "args": ["stdio"]
    }
  }
}
```

### 3. Install the Chrome Extension
*(Installation instructions for the Chrome Extension via the Chrome Web Store will be placed here upon publication.)*

---

## 🗣 How to Share Feedback

We want to build the ultimate AI browser integration, and your feedback is critical to that mission.

*   🐛 **Found a bug?** 
    Please submit a report via the **Issues** tab. 
    *Tip: The easiest way to report a bug is directly through the "Support & Feedback" section in the MCP Tab Control Chrome Extension. This allows you to securely attach sanitized diagnostic logs, helping us resolve issues much faster.*

*   💡 **Have an idea or a question?**
    Join the conversation in the **Discussions** tab. We'd love to hear your feature requests, workflow ideas, and general questions.
