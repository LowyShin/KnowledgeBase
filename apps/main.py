import os
import requests
from apps.file_reader.reader import read_md_files
from apps.file_reader.parser import parse_md_files
from apps.link_checker.checker import check_url

def save_broken_links_to_file(broken_links, output_dir):
    """Save the broken links to a .txt file in the specified directory."""
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, "broken_links_fixed.txt")
    with open(output_file, "w", encoding="utf-8") as f:
        for file_name, url, suggestion in broken_links:
            f.write(f"{file_name}: {url} -> Suggested: {suggestion}\n")
    print(f"Fixed broken links saved to {output_file}")

def suggest_alternative_links(url):
    """Suggest alternative links for broken URLs."""
    suggestions = {
        "https://yippeee.tistory.com/79": "https://tistory.com",
        # Add more mappings as needed
    }
    return suggestions.get(url, "No suggestion available")

def find_alternative_link(broken_url):
    """Find an alternative link for a broken URL."""
    # Placeholder for actual implementation to find alternative links
    # For now, return a generic suggestion
    return "https://example.com"

def save_broken_links_with_alternatives(broken_links, output_dir):
    """Save the broken links with alternatives to a .txt file in the specified directory."""
    os.makedirs(output_dir, exist_ok=True)
    output_file = os.path.join(output_dir, "broken_links_with_alternatives.txt")
    with open(output_file, "w", encoding="utf-8") as f:
        f.write("| File Path | Broken Link | Suggested Alternative |\n")
        f.write("|-----------|-------------|-----------------------|\n")
        for file_path, url in broken_links:
            alternative = find_alternative_link(url)
            f.write(f"| {file_path} | {url} | {alternative} |\n")
    print(f"Broken links with alternatives saved to {output_file}")

def main():
    directory = "./"  # Root directory of the project
    output_dir = "./evidence"  # Directory to save the results

    md_files = read_md_files(directory)
    url_map = parse_md_files(md_files)

    broken_links = []
    for file_name, urls in url_map.items():
        for url in urls:
            if not check_url(url):
                suggestion = suggest_alternative_links(url)
                broken_links.append((file_name, url, suggestion))

    if broken_links:
        print("Broken links found:")
        for file_name, url, suggestion in broken_links:
            print(f"{file_name}: {url} -> Suggested: {suggestion}")
        save_broken_links_to_file(broken_links, output_dir)
        save_broken_links_with_alternatives(broken_links, output_dir)
    else:
        print("No broken links found.")

if __name__ == "__main__":
    main()