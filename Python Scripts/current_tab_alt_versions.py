import requests
from bs4 import BeautifulSoup
import logging
import sys

logging.basicConfig(
    level=logging.INFO,
    # level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(message)s",
    handlers=[
        logging.StreamHandler(sys.stdout)
    ]
)

# CONFIGURATION settings for testing
ALTERYX_RELEASE_PAGE = "https://help.alteryx.com/release-notes"
TABLEAU_RELEASE_PAGE = "https://www.tableau.com/support/releases"


def alteryx_version_scraper(alteryx_release_page: str) -> str:
    """method to find the current Alteryx versions."""

    alteryx_page = requests.get(alteryx_release_page)
    logging.debug(f'Alteryx Release Page: {alteryx_page}')

    alteryx_version = []
    soup = BeautifulSoup(alteryx_page.text, "html.parser")
    for version in soup.find_all("div", {"class": "release-note--version"}):
        if version.text.startswith("Version"):
            alteryx_version.append(float(version.text.split()[-1]))

        logging.debug(f'Alteryx Version: {alteryx_version}')

    alteryx_version_type = type(alteryx_version)
    alteryx_version_max = max(alteryx_version)

    logging.debug(f'Alteryx release note: {alteryx_version_max}')
    logging.debug(f'Alteryx release note: {alteryx_version_type}')
    return alteryx_version_max


def tableau_version_scraper(tableau_release_page: str) -> str:
    """method to find the current Tableau versions."""

    tableau_page = requests.get(tableau_release_page)
    logging.debug(f'Tableau Release Page: {tableau_page}')

    tableau_version = []
    soup = BeautifulSoup(tableau_page.text, "html.parser")
    headings = soup.find_all("h3", {"class": "heading--h5"})
    logging.debug(f'Tableau Headings: {headings}')
    for version in soup.find_all("h3", {"class": "heading--h5"}):
        # if version.text.startswith("Version"):
        tableau_version.append(float(version.text.split()[0]))
        # tableau_version = [float(i) for i in tableau_version]
        logging.debug(f'Tableau Version: {tableau_version}')

    tableau_version_type = type(tableau_version)
    tableau_version_max = max(tableau_version)

    logging.debug(f'Tableau release note: {tableau_version_max}')
    logging.debug(f'Tableau release note: {tableau_version_type}')
    return tableau_version_max


def main(alteryx_release_page: str,
         tableau_release_page: str) -> dict:
    """
    Script to find the current Alteryx and Tableau versions.
    On the 7 December the release pages are located:
    Alteryx: https://www.alteryx.com/release-notes/
    Tableau: https://www.tableau.com/products/downloads/release-notes/
    """

    alteryx_version = alteryx_version_scraper(alteryx_release_page)
    logging.info(f'Alteryx Version: {alteryx_version}')

    tableau_version = tableau_version_scraper(tableau_release_page)
    logging.info(f'Tableau Version: {tableau_version}')
    return {'Alteryx': alteryx_version, 'Tableau': tableau_version}


if __name__ == "__main__":
    main(ALTERYX_RELEASE_PAGE, TABLEAU_RELEASE_PAGE)
