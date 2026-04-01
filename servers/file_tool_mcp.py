import os
from mcp.server.fastmcp import FastMCP

# MCP instance
mcp = FastMCP("FileTool")
print("MCP FileTool started...")

# Base directory for files
BASE_DIR = os.path.join(os.path.dirname(__file__), "data")
os.makedirs(BASE_DIR, exist_ok=True)

@mcp.tool()
def create_files(count: int = 1, prefix: str = "file") -> dict:
    """Create `count` files with unique content."""
    created_files = []
    for i in range(1, count + 1):
        filename = f"{prefix}_{i}.txt"
        filepath = os.path.join(BASE_DIR, filename)
        content = f"This is file number {i}. Generated dynamically by MCP."
        with open(filepath, "w", encoding="utf-8") as f:
            f.write(content)
        created_files.append(filename)
    return {"status": f"{count} files created", "files": created_files}

@mcp.tool()
def list_files() -> dict:
    """List all files in BASE_DIR."""
    files = os.listdir(BASE_DIR)
    return {"files": files, "base_dir": BASE_DIR}

@mcp.tool()
def read_file(filename: str) -> dict:
    """Read content of a file."""
    filepath = os.path.join(BASE_DIR, filename)
    if not os.path.isfile(filepath):
        return {"error": "File does not exist"}
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
    return {"filename": filename, "content": content}

@mcp.tool()
def edit_file(filename: str, new_content: str) -> dict:
    """Edit content of a file (overwrite)."""
    filepath = os.path.join(BASE_DIR, filename)
    if not os.path.isfile(filepath):
        return {"error": "File does not exist"}
    with open(filepath, "w", encoding="utf-8") as f:
        f.write(new_content)
    return {"status": "File edited successfully", "filename": filename}

@mcp.tool()
def delete_file(filename: str) -> dict:
    """Delete a file."""
    filepath = os.path.join(BASE_DIR, filename)
    if not os.path.isfile(filepath):
        return {"error": "File does not exist"}
    os.remove(filepath)
    return {"status": "File deleted successfully", "filename": filename}

if __name__ == "__main__":
    mcp.run()