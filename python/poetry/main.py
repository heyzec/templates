import numpy as np
import requests
import requests_cache

def numpy_example():
    # Create arrays
    a = np.array([1, 2, 3, 4, 5])
    b = np.array([5, 4, 3, 2, 1])

    # Element-wise operations
    sum_ab = a + b          # Element-wise addition
    diff_ab = a - b         # Element-wise subtraction
    prod_ab = a * b         # Element-wise multiplication
    quot_ab = a / b         # Element-wise division

    print("Sum:", sum_ab)
    print("Difference:", diff_ab)
    print("Product:", prod_ab)
    print("Quotient:", quot_ab)

def requests_example():
    requests_cache.install_cache('/tmp/requests_cache')
    r = requests.get("https://httpbun.com/get")
    print(f"From cache: {r.from_cache}")

def main():
    numpy_example()
    requests_example()

if __name__ == '__main__':
    main()
