import os


def parse_file(file):
    result = '[\n'
    with open(file, 'r') as f:
        for line in f:
            second, *reste = line.split()
            reste = ["\"" + r + "\"" for r in reste]
            result += f'[{second},{",".join(reste)}],\n'
    result += '],\n'
    return result


result = '[\n'
for directory in ["Level1", "Level2", "Level3", "Level4"]:
    onlyfiles = [f for f in os.listdir(directory) if os.path.isfile(os.path.join(directory, f))]
    result += '[\n'
    for file in onlyfiles:
        result += parse_file(os.path.join(directory, file))
    result += '],\n'
result += ']\n'

print(result)