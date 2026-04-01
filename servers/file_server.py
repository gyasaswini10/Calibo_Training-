from mcp.server.fastmcp import FastMCP
import os

mcp = FastMCP("file-server")

# -------------------------
# BASE DIRECTORY (SAFE ZONE)
# -------------------------
BASE_DIR = os.path.join(os.getcwd(), "data")

if not os.path.exists(BASE_DIR):
    os.makedirs(BASE_DIR)

# -------------------------
# HELPER FUNCTIONS
# -------------------------
def safe_path(path: str) -> str:
    """Prevent access outside base directory"""
    full_path = os.path.abspath(os.path.join(BASE_DIR, path))
    if not full_path.startswith(BASE_DIR):
        raise Exception("Access denied (outside base directory)")
    return full_path

def ensure_dir(path: str):
    folder = os.path.dirname(path)
    if folder and not os.path.exists(folder):
        os.makedirs(folder)

# -------------------------
# CREATE FILE
# -------------------------
@mcp.tool()
def create_file(path: str) -> str:
    try:
        path = safe_path(path)
        ensure_dir(path)
        with open(path, "w", encoding="utf-8"):
            pass
        return "file created"
    except Exception as e:
        return str(e)

# -------------------------
# WRITE (overwrite)
# -------------------------
@mcp.tool()
def write_file(path: str, content: str) -> str:
    try:
        path = safe_path(path)
        ensure_dir(path)
        with open(path, "w", encoding="utf-8") as f:
            f.write(content)
        return "written"
    except Exception as e:
        return str(e)

# -------------------------
# APPEND (ENTER)
# -------------------------
@mcp.tool()
def append_file(path: str, content: str) -> str:
    try:
        path = safe_path(path)
        ensure_dir(path)
        with open(path, "a", encoding="utf-8") as f:
            f.write(content)
        return "appended"
    except Exception as e:
        return str(e)

# -------------------------
# READ FILE
# -------------------------
@mcp.tool()
def read_file(path: str) -> str:
    try:
        path = safe_path(path)
        with open(path, "r", encoding="utf-8") as f:
            return f.read()
    except Exception as e:
        return str(e)

# -------------------------
# CLEAR FILE
# -------------------------
@mcp.tool()
def clear_file(path: str) -> str:
    try:
        path = safe_path(path)
        open(path, "w").close()
        return "cleared"
    except Exception as e:
        return str(e)

# -------------------------
# DELETE FILE
# -------------------------
@mcp.tool()
def delete_file(path: str) -> str:
    try:
        path = safe_path(path)
        os.remove(path)
        return "deleted"
    except Exception as e:
        return str(e)

# -------------------------
# LIST FILES
# -------------------------
@mcp.tool()
def list_files(folder: str = "") -> list:
    try:
        folder_path = safe_path(folder)
        return os.listdir(folder_path)
    except Exception as e:
        return [str(e)]

# -------------------------
# UPDATE (REPLACE TEXT)
# -------------------------
@mcp.tool()
def update_file(path: str, old: str, new: str) -> str:
    try:
        path = safe_path(path)
        with open(path, "r", encoding="utf-8") as f:
            data = f.read()

        data = data.replace(old, new)

        with open(path, "w", encoding="utf-8") as f:
            f.write(data)

        return "updated"
    except Exception as e:
        return str(e)

# -------------------------
# RUN SERVER
# -------------------------
if __name__ == "__main__":
    print("Server running...")
    print("Base directory:", BASE_DIR)
    mcp.run()