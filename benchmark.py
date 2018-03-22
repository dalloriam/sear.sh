from tqdm import tqdm

import json
import requests
import time

URL = "localhost:1500/put/"


def timing(f):
    def wrap(*args):
        time1 = time.time()
        ret = f(*args)
        time2 = time.time()
        print(f'{f.__name__} took {(time2 - time1) * 1000.0}')
        return ret
    return wrap

@timing
def benchmark():
    struct = {
        'field_1': 'abcd',
        'field_2': ''
    }

    for i in tqdm(range(4000)):
        struct['field_2'] = str(i) * 3
        requests.get(f"http://localhost:1500/put/{json.dumps(struct)}")


if __name__ == '__main__':
    benchmark()