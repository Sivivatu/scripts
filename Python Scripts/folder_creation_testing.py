from pathlib import Path

dirs = ["C:\\Users\\paulj\\directory_test\\1-One",
        "C:\\Users\\paulj\\directory_test\\2-Two",
        "C:\\Users\\paulj\\directory_test\\3-Three"]

for folder in dirs:
    Path(folder).mkdir(parents=True, exist_ok=True)
