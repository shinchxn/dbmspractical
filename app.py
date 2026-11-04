from pathlib import Path
from fastapi import FastAPI, HTTPException
from fastapi.responses import FileResponse, PlainTextResponse

app = FastAPI(title="DBMS SQL Static Server")

BASE_DIR = Path(__file__).resolve().parent / "DBMS_Flat_15"

@app.get("/", response_class=PlainTextResponse)
def index():
    if not BASE_DIR.is_dir():
        return "DBMS_Flat_15 directory not found.\n"
    
    files = sorted(
        [f.name for f in BASE_DIR.glob("*.sql")],
        key=lambda x: int(x.split(".")[0]) if x.split(".")[0].isdigit() else x
    )
    listing = "\n".join(f"  - {f}" for f in files)
    return (
        "=== DBMS Script Server ===\n\n"
        f"Available files ({len(files)} total):\n"
        f"{listing}\n\n"
        "Usage examples:\n"
        "  curl -O http://<server-ip>:8000/<filename>.sql\n"
        "  curl http://<server-ip>:8000/<filename>.sql\n"
    )

@app.get("/{filename}")
def get_file(filename: str):
    # Auto-append .sql if only the number or base name was passed (e.g. /10 -> /10.sql)
    if not filename.endswith(".sql"):
        sql_candidate = f"{filename}.sql"
        if (BASE_DIR / sql_candidate).is_file():
            filename = sql_candidate

    target_path = (BASE_DIR / filename).resolve()

    # Prevent directory traversal
    if BASE_DIR.resolve() not in target_path.parents and target_path != BASE_DIR.resolve():
        raise HTTPException(status_code=403, detail="Access denied")

    if not target_path.is_file():
        raise HTTPException(status_code=404, detail=f"File '{filename}' not found")

    return FileResponse(
        path=target_path,
        media_type="text/plain; charset=utf-8",
        filename=target_path.name
    )

if __name__ == "__main__":
    import uvicorn
    # Bind to 0.0.0.0 to allow access from local machine and local network
    uvicorn.run(app, host="0.0.0.0", port=8000)

