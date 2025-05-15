import os

def read_md_files(directory):
    """Read all .md files in a directory and return their content."""
    md_files = []
    for root, _, files in os.walk(directory):
        for file in files:
            if file.endswith('.md'):
                with open(os.path.join(root, file), 'r', encoding='utf-8') as f:
                    md_files.append((file, f.read()))
    return md_files