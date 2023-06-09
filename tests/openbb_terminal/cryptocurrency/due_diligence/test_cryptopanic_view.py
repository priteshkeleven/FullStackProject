import pytest

from openbb_terminal.cryptocurrency.due_diligence import cryptopanic_view


@pytest.fixture(scope="module")
def vcr_config():
    return {
        "filter_headers": [("User-Agent", None)],
        "filter_query_parameters": [
            ("auth_token", "AUTH_TOKEN"),
        ],
    }


@pytest.mark.vcr
@pytest.mark.record_stdout
def test_display_news():
    cryptopanic_view.display_news(symbol="btc-bitcoin", source="cp")
