import re

def extract_urls_from_text(text):
    """Extract all URLs from a given text."""
    url_pattern = r'https?://[^"]+'  # Matches URLs starting with http or https
    return re.findall(url_pattern, text)