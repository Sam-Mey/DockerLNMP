import os
from natsort import natsorted


# def get_sh_file_paths(directory):
#     sh_file_paths = []
#     for root, dirs, files in os.walk(directory):
#         for file in files:
#             if file.endswith(".sh"):
#                 rel_path = os.path.relpath(os.path.join(root, file), directory)
#                 # 将反斜杠替换为正斜杠
#                 rel_path = rel_path.replace("\\", "/")
#                 sh_file_paths.append(rel_path)
#     return sh_file_paths

def get_sh_file_paths(directory, excluded_dir=None):
    sh_file_paths = []
    for root, dirs, files in os.walk(directory):
        # 排除指定的子目录
        if excluded_dir and excluded_dir in dirs:
            dirs.remove(excluded_dir)
            continue

        for file in files:
            if file.endswith(".sh"):
                rel_path = os.path.relpath(os.path.join(root, file), directory)
                rel_path = rel_path.replace("\\", "/")
                sh_file_paths.append(rel_path)
    return sh_file_paths


def write_to_config_sh(file_paths, output_file="config.sh"):
    # 移动SCRIPT_DIR的定义到函数内部
    SCRIPT_DIR = "/DockerLNMP"

    with open(output_file, "w", encoding="utf-8") as config_file:
        config_file.write("#!/bin/bash\n\n")
        config_file.write("# enter script pwd\n")
        config_file.write('cd "$(dirname "${BASH_SOURCE[0]}")"\n\n')
        config_file.write('# script working path\n')
        config_file.write(f'SCRIPT_DIR="{SCRIPT_DIR}"\n\n')

        written_paths = set()  # 用于追踪已写入的脚本路径

        # 使用 natsorted 进行自然排序，按照脚本名称排序
        sorted_paths = natsorted(file_paths, key=lambda x: os.path.basename(x))

        for path in sorted_paths:
            script_name = os.path.basename(path).split(".")[0]  # 获取脚本名，去除文件扩展名
            script_variable = f'{
                script_name.upper()}_SCRIPT_PATH="$SCRIPT_DIR/{path}"'

            # 只有在存在路径且未写入过的情况下才写入原始路径
            if path != "" and script_variable not in written_paths:
                config_file.write(f'{script_variable}\n')
                written_paths.add(script_variable)

        config_file.write("\n")
        config_file.write("# other config...\n")
        config_file.write("\n")
        config_file.write("# # path debug\n")

        # 将所有路径写一个打印调试信息并放在最后
        for path in sorted_paths:
            script_name = os.path.basename(path).split(".")[0]
            script_variable = f'{script_name.upper()}_SCRIPT_PATH: ${
                script_name.upper()}_SCRIPT_PATH'
            # 开发模式请将 '# echo' 前面的 '#' 号去掉
            config_file.write(f'# echo "{script_variable}"\n')

# if __name__ == "__main__":
#     docker_lnmp_directory = os.getcwd()  # 获取当前工作目录作为 docker_lnmp 项目的路径
#     sh_file_paths = get_sh_file_paths(docker_lnmp_directory)

#     if sh_file_paths:
#         write_to_config_sh(sh_file_paths)
#         print("路径已写入 config.sh 文件。")
#     else:
#         print("未找到任何 .sh 文件。")

if __name__ == "__main__":
    docker_lnmp_directory = os.getcwd()
    excluded_dir = "lnmp"  # 要排除的目录名

    sh_file_paths = get_sh_file_paths(docker_lnmp_directory, excluded_dir)

    if sh_file_paths:
        write_to_config_sh(sh_file_paths)
        print("路径已写入 config.sh 文件。")
    else:
        print("未找到任何 .sh 文件。")
