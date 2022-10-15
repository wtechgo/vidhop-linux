import argparse
import json
import warnings
from pprint import pprint

from imagescraper import ImageScraper
# from scrapers.image_scraper import ImageScraper
from facebook_scraper import get_posts, exceptions as scraper_exceptions, get_photos


# https://github.com/kevinzg/facebook-scraper
# https://github.com/bisguzar/twitter-scraper
class FacebookScraper:
    dest_dir = None
    cookies_txt = "/data/code/vidhop/scrapers/cookies/facebook_cookies.txt"
    cookies_json = "/data/code/vidhop/scrapers/cookies/facebook_cookies.json"
    domain_cookies_json = "/data/code/vidhop/scrapers/cookies/facebook_domain_cookies.json"

    def __init__(self, dest_dir_abs_path: str = None) -> None:
        super().__init__()
        self.dest_dir = dest_dir_abs_path

    def should_redirect(self, url: str):
        if 'facebook.com/photo/?fbid' in url:
            return True
        else:
            return False

    def scrape_images(self, post: dict):
        img_urls = post.get('images', None)
        if img_urls is None:
            print("no images in post, abort image scrape")
            return
        if self.dest_dir is None:
            print("no target directory defined for images, abort image scrape")
            return
        try:
            print("post has images, trying to fetch images...")
            image_scraper = ImageScraper(self.dest_dir)
            image_scraper.scrape_urls(img_urls)
            print("Images saved!")
        except PermissionError as error:
            print(f"{str(error)}, abort image scrape")

    def silence_warning(self):
        # Suppresses the following 2 warnings.
        language_error = "/home/freetalk/.local/share/virtualenvs/vidhop-4Px9w5UP/lib/python3.10/site-packages/facebook_scraper/facebook_scraper.py:855: UserWarning: Facebook language detected as nl_BE - for best results, set to en_US"
        localize_error = "/home/freetalk/.local/share/virtualenvs/vidhop-4Px9w5UP/lib/python3.10/site-packages/dateparser/freshness_date_parser.py:76: PytzUsageWarning: The localize method is no longer necessary, as this time zone supports the fold attribute (PEP 495). For more details on migrating to a PEP 495-compliant implementation, see https://pytz-deprecation-shim.readthedocs.io/en/latest/migration.html; now = self.get_local_tz().localize(now)"
        warnings.filterwarnings("ignore", category=UserWarning)
        warnings.filterwarnings("ignore",
                                message="The localize method is no longer necessary, as this time zone supports the fold attribute")

    def fetch_post(self, url: str):
        self.silence_warning()
        try:
            # posts_gen = get_posts(post_urls=[url], cookies=self.domain_cookies_json, options={"comments": True})
            posts_gen = get_posts(
                post_urls=[url],
                options={"comments": True},
            )  # cookies_txt  cookies_json  domain_cookies_json
            post = next(posts_gen)
            # if self.should_redirect(url):
            #     post_url = post.get('post_url', None)
            #     self.fetch_post(post_url)
            #     return
            # self.scrape_images(post)

            pprint(json.dumps(post, sort_keys=True, default=str))
        except scraper_exceptions.NotFound:
            print(f"post not found, has it been removed?")
            exit()


if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='Twitter Scraper.')
    parser.add_argument('-u', '--url', help='the url of the post', required=True)
    parser.add_argument('-d', '--dir', help='the dir of the post', required=False)
    args = parser.parse_args()
    if args.dir is not None:
        scraper = FacebookScraper(args.dir)
    else:
        scraper = FacebookScraper()
    scraper.fetch_post(args.url)
