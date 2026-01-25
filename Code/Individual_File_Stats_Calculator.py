import Percent_Difference_Method as pdm
from pathlib import Path
import os


if __name__ == "__main__":
    filepath = input("Input Full File Path: ").strip()
    # Remove surrounding quotes if pasted
    if (filepath.startswith('"') and filepath.endswith('"')) or (filepath.startswith("'") and filepath.endswith("'")):
        filepath = filepath[1:-1]
    # Expand user (~) and environment variables
    filepath = os.path.expandvars(os.path.expanduser(filepath))
    # Normalize separators and path
    filepath = os.path.normpath(filepath)
    pdm.calculate_percent_differences(str(Path(filepath)))