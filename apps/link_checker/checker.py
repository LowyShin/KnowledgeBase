import requests

def check_url(url):
    """Check if a URL is reachable."""
    try:
        response = requests.head(url, allow_redirects=True, timeout=5)
        return response.status_code == 200
    except requests.RequestException:
        return False