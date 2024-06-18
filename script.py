import subprocess

def run_test(program, test_input):
    print(f"Running test with input: '{test_input}'")
    process = subprocess.Popen(program, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    stdout, stderr = process.communicate(input=test_input)
    return stdout.strip(), stderr.strip()

def main():
    print("Running tests...\n")

    program = "./mytool"  # Change to the correct path to your executable
    with open("test_cases.txt", "r") as f:
        tests = f.readlines()
    print(f"Running on {len(tests)} tests...\n" )

    passed = 0
    failed = 0

    for index, test in enumerate(tests):
        print("-" * 10 + f" test {index} " + "-" * 10)
        test_input, expected_output = test.strip().split(';')
        test_input = test_input
        expected_output = expected_output.strip()
        
        actual_output, error_output = run_test(program, test_input + "\n")
        
        print(f"Test input: '{test_input}'")
        print(f"Expected output: '{expected_output}'")
        print(f"Actual output: '{actual_output}'")
        if error_output:
            print(f"Error running test '{test_input}': {error_output}")
            failed += 1
        elif expected_output in actual_output:
            print(f"Test passed for input '{test_input}'")
            passed += 1
        else:
            print(f"Test failed for input '{test_input}'")
            print(f"Expected: '{expected_output}'")
            print(f"Got: '{actual_output}'")
            failed += 1
    
    print(f"\nTotal tests passed: {passed}")
    print(f"Total tests failed: {failed}")

if __name__ == "__main__":
    main()
