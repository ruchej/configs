#!/usr/bin/python

import shutil
from pathlib import Path


configs = Path.cwd() / 'home'
home = Path.home()


def rm(path: Path) -> None:
    '''удаляет файл или директорию'''
    if path.exists():
        if path.is_symlink():
            path.unlink()
            print(f'Deleted symlink {path}')
        elif path.is_dir():
            shutil.rmtree(path)
            print(f'Deleted directory {path}')
        else:
            path.unlink()
            print(f'Deleted file {path}')

for d in configs.joinpath(Path('.config')).iterdir():
    target_dir = home.joinpath(Path('.config'), Path(d.name))
    rm(target_dir)
    target_dir.symlink_to(d)
    print(f'Create symlink {target_dir} to {d}')

for d in configs.iterdir():
    if d.name == '.config':
        continue
    target_dir = home.joinpath(Path(d.name))
    rm(target_dir)
    target_dir.symlink_to(d)
    print(f'Create symlink {target_dir} to {d}')

