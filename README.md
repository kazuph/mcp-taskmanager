# MCP TaskManager

Model Context Protocol server for Task Management. This allows Claude Desktop (or any MCP client) to manage and execute tasks in a queue-based system.

<a href="https://glama.ai/mcp/servers/bdjh7kx05h"><img width="380" height="200" src="https://glama.ai/mcp/servers/bdjh7kx05h/badge" alt="@kazuph/mcp-taskmanager MCP server" /></a>

## Quick Start (For Users)

### Prerequisites
- Node.js 18+ (install via `brew install node`)
- Claude Desktop (install from https://claude.ai/desktop)

### Configuration

1. Open your Claude Desktop configuration file at:
`~/Library/Application Support/Claude/claude_desktop_config.json`

You can find this through the Claude Desktop menu:
1. Open Claude Desktop
2. Click Claude on the Mac menu bar
3. Click "Settings"
4. Click "Developer"

2. Add the following to your configuration:

```json
{
  "tools": {
    "taskmanager": {
      "command": "npx",
      "args": ["-y", "@kazuph/mcp-taskmanager"]
    }
  }
}
```

## For Developers

### Prerequisites
- Node.js 18+ (install via `brew install node`)
- Claude Desktop (install from https://claude.ai/desktop)
- tsx (install via `npm install -g tsx`)

### Installation

```bash
git clone https://github.com/kazuph/mcp-taskmanager.git
cd mcp-taskmanager
npm install
npm run build
```

### Development Configuration

1. Make sure Claude Desktop is installed and running.

2. Install tsx globally if you haven't:
```bash
npm install -g tsx
# or
pnpm add -g tsx
```

3. Modify your Claude Desktop config located at:
`~/Library/Application Support/Claude/claude_desktop_config.json`

Add the following to your MCP client's configuration:

```json
{
  "tools": {
    "taskmanager": {
      "args": ["tsx", "/path/to/mcp-taskmanager/index.ts"]
    }
  }
}
```

## Available Operations

The TaskManager supports two main phases of operation:

### Planning Phase
- Accepts a task list (array of strings) from the user
- Stores tasks internally as a queue
- Returns an execution plan (task overview, task ID, current queue status)

### Execution Phase
- Returns the next task from the queue when requested
- Provides feedback mechanism for task completion
- Removes completed tasks from the queue
- Prepares the next task for execution

### Parameters

- `action`: "plan" | "execute" | "complete"
- `tasks`: Array of task strings (required for "plan" action)
- `taskId`: Task identifier (required for "complete" action)
- `getNext`: Boolean flag to request next task (for "execute" action)

## Example Usage

```typescript
// Planning phase
{
  action: "plan",
  tasks: ["Task 1", "Task 2", "Task 3"]
}

// Execution phase
{
  action: "execute",
  getNext: true
}

// Complete task
{
  action: "complete",
  taskId: "task-123"
}
```
