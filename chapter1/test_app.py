from app import app


def test_home():
    client = app.test_client()
    response = client.get("/")
    assert response.status_code == 200
    assert b"App is running" in response.data


# from app import add, subtract


# def test_add():
#     assert add(2, 3) == 5


# def test_subtract():
#     assert subtract(5, 3) == 2