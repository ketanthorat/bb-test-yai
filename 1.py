import os

structure = {
    "tests": ["test_pin17.py", "test_pin23.py", "helpers.py"],
    "scripts": ["setup.sh", "run_tests.sh", "cleanup.sh"],
    "reports": ["report.html"]
}

root = "gpio-test"

for folder, files in structure.items():
    path = os.path.join(root, folder)
    os.makedirs(path, exist_ok=True)
    for file in files:
        open(os.path.join(path, file), "w").close()

print("Project structure created successfully!")
