from apps.link_checker.utils import extract_urls_from_text

def parse_md_files(md_files):
    """Parse Markdown files and extract URLs."""
    url_map = {}
    for file_name, content in md_files:
        urls = extract_urls_from_text(content)
        url_map[file_name] = urls
    return url_map