import os

import uvicorn
from dotenv import load_dotenv

load_dotenv()

uvicorn.run("api.main:app", host="0.0.0.0", port=int(os.environ.get("PORT", 8000)))
