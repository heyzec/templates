import logging

def _setup_logging() -> None:
    from typing import override

    class ColorFormatter(logging.Formatter):
        COLORS: dict[int, str] = {
            logging.DEBUG: "\033[90m",
            logging.WARNING: "\033[33m",
            logging.ERROR: "\033[31m",
            logging.CRITICAL: "\033[31;1m",
        }
        RESET: str = "\033[0m"

        @override
        def format(self, record: logging.LogRecord) -> str:
            msg = super().format(record)
            colour = self.COLORS.get(record.levelno, "")
            return f"{colour}{msg}{self.RESET}" if colour else msg

    handler = logging.StreamHandler()
    handler.setFormatter(ColorFormatter("%(asctime)s %(levelname)s:%(name)s %(message)s", datefmt="%Y-%m-%d %H:%M:%S"))
    logging.basicConfig(handlers=[handler], level=logging.DEBUG)

_setup_logging()
logger = logging.getLogger(__name__)

if __name__ == '__main__':
    logger.debug("Detailed information for diagnosing problems.")
    logger.info("Confirmation that things are working as expected.")
    logger.warning("Something unexpected happened, or may happen in the near future; the software is still working as expected.")
    logger.error("A more serious problem prevented the software from performing some function.")
    logger.critical("A serious error; the software may be unable to continue running.")
