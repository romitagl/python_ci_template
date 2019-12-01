import pytest
import sys
# include src and folder (depending if running locally or in the container)
sys.path.append("../src")
sys.path.append("../app")
# import hello_world function from the app.py file
from app import hello_world
 
def test_hello_world():
  assert hello_world() == "hello world"

if __name__ == "__main__":
  # run pytest
  pytest.main(sys.argv)