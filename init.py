#!/usr/bin/python

import shutil
from pathlib import Path


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


def make_symlink(config_dir: Path, target_dir: Path, exclude: tuple[str] = ('',)) -> None:

    for d in config_dir.iterdir():
        if d.name in exclude:
            continue
        target = target_dir.joinpath(Path(d.name))
        rm(target)
        target.symlink_to(d)
        print(f'Create symlink {target} to {d}')


if __name__ == '__main__':

    configs = Path.cwd() / 'home'
    home = Path.home()
    make_symlink(configs.joinpath(Path('.config')), home.joinpath(Path('.config')))
    make_symlink(configs, home, exclude=('.config',))
