import re
import shutil

def load_exclude_patterns(exclude_file):
    """ Load and adjust exclusion patterns from the specified file. """
    adjusted_patterns = []
    with open(exclude_file, 'r') as file:
        for line in file:
            pattern = line.strip()
            if pattern:
                # Adjust the patterns
                pattern = pattern.replace('**/*', '*')  # Replace '**' with '.*'
                pattern = pattern.replace('*', '.*')   # Replace '*' with '.*' for directories
                
                # Add the adjusted pattern to the list if it is valid
                try:
                    re.compile(pattern)  # Validate the regex
                    adjusted_patterns.append(pattern)
                except re.error as e:
                    print(f"Invalid pattern '{pattern}': {e}")

    return adjusted_patterns

exclude_file = 'coverage_excludes.txt'
exclude_patterns = load_exclude_patterns(exclude_file)

def exclude_files(input_file, temp_file, exclude_patterns):
    with open(input_file, 'r') as file:
        lines = file.readlines()
    with open(temp_file, 'w') as file:
        skip_record = False
        for line in lines:
            if line.startswith('SF:'):
                path = line[3:].replace("\\", '/').strip()
                # Check against adjusted patterns
                if any(re.fullmatch(pattern, path) for pattern in exclude_patterns):
                    skip_record = True
            
            if skip_record:
                if line.startswith('end_of_record'):
                    skip_record = False
            else:
                file.write(line)

if __name__ == "__main__":
    input_filename = 'coverage/lcov.info' 
    temp_filename = 'coverage/lcov_filtered.tmp'

    exclude_files(input_filename, temp_filename, exclude_patterns)

    shutil.move(temp_filename, input_filename)
    print("Original coverage file has been replaced with the filtered version.")
