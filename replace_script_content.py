import os
import re


def replace_in_file(file_path, old_str, new_str):
    with open(file_path, 'r', encoding='utf-8') as file:
        file_content = file.read()

    # 使用正则表达式进行大小写不敏感的替换
    new_content = re.compile(re.escape(old_str), re.IGNORECASE).sub(
        new_str, file_content)

    with open(file_path, 'w', encoding='utf-8') as file:
        file.write(new_content)


def replace_in_all_files(directory, old_str, new_str):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith((".txt", ".md", ".sh")):  # 可以根据实际需要添加其他文件扩展名
                file_path = os.path.join(root, file)
                replace_in_file(file_path, old_str, new_str)


if __name__ == "__main__":
    current_directory = os.getcwd()
    # 将：
    old_string = "docker_lnmp"
    # 替换为：
    new_string = "DockerLNMP"

    replace_in_all_files(current_directory, old_string, new_string)

    print(f"已将所有文件中的 '{old_string}' 替换为 '{new_string}'。")
