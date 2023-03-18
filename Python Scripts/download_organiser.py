import os
import logging
from shutil import move


# ! FILL IN BELOW
# ? folder to track e.g. Windows: "C:\\Users\\UserName\\Downloads"
source_dir = 'C:\\Users\\paulj\\Downloads'
dest_dir_archive = os.path.join(source_dir, 'archive')
dest_dir_music = os.path.join(source_dir, 'music')
dest_dir_video = os.path.join(source_dir, 'video')
dest_dir_image = os.path.join(source_dir, 'image')
dest_dir_documents = os.path.join(source_dir, 'documents')
logging.info('Starting download_organiser.py')
logging.info(f'{dest_dir_archive}')
logging.info(f'{dest_dir_documents}')


# ? supported image types
image_extensions = [".jpg", ".jpeg", ".jpe", ".jif", ".jfif", ".jfi", ".png",
                    ".gif", ".webp", ".tiff", ".tif", ".psd", ".raw", ".arw",
                    ".cr2", ".nrw", ".k25", ".bmp", ".dib", ".heif", ".heic",
                    ".ind", ".indd", ".indt", ".jp2", ".j2k", ".jpf", ".jpf",
                    ".jpx", ".jpm", ".mj2", ".svg", ".svgz", ".ai", ".eps",
                    ".ico"]
# ? supported Video types
video_extensions = [".webm", ".mpg", ".mp2", ".mpeg", ".mpe", ".mpv", ".ogg",
                    ".mp4", ".mp4v", ".m4v", ".avi", ".wmv", ".mov", ".qt",
                    ".flv", ".swf", ".avchd"]

# ? supported Audio types
audio_extensions = [".m4a", ".flac", "mp3", ".wav", ".wma", ".aac"]

# ? supported Document types
document_extensions = [".doc", ".docx", ".odt", ".csv", ".txt", ".yxi",
                       ".yxdb", ".yxmd", ".yxmc", ".pdf", ".xls", ".xlsx",
                       ".ppt", ".pptx"]

# ? supported archive types
archive_extensions = [".zip", ".iso", ".rar", ".7z", ".tar", ".gz", ".bz2",
                      ".xz", ".z", ".jar", ".cab", ".dmg", ".apk", ".ipa",
                      ".xpi", ".rpm", ".deb", ".msi", ".exe"]


logging.basicConfig(level=logging.DEBUG,
                    format=' %(asctime)s - %(levelname)s - %(message)s',
                    datefmt='%Y/%m/%d %H:%M:%S')


def make_unique(path):
    filename, extension = os.splitext(path)
    counter = 1
    # * IF FILE EXISTS, ADDS NUMBER TO THE END OF THE FILENAME
    while os.path.exists(path):
        path = f"{filename} ({counter}){extension}"
        counter += 1
    return path


def folder_exists(folder):
    if not os.path.exists(folder):
        os.makedirs(folder)


def move_file(dest, entry, name):
    if os.path.exists(f"{dest}/{name}"):
        unique_name = make_unique(name)
        os.rename(entry, unique_name)
    move(entry, dest)


def check_archive_files(entry, name):  # * Checks all Video Files
    folder_exists(dest_dir_archive)
    for archive_extension in archive_extensions:
        if name.endswith(archive_extension) or name.endswith(archive_extension.upper()):
            move_file(dest_dir_archive, entry, name)
            logging.info(f"Moved archive file: {name}")


def check_document_files(entry, name):  # * Checks all Video Files
    folder_exists(dest_dir_documents)
    for document_extension in document_extensions:
        if name.endswith(document_extension) or name.endswith(document_extension.upper()):
            move_file(dest_dir_documents, entry, name)
            logging.info(f"Moved document file: {name}")

            # self.check_audio_files(entry, name)
            # self.check_video_files(entry, name)
            # self.check_image_files(entry, name)


def main():
    with os.scandir(source_dir) as entries:
        logging.info(f'checking files in {source_dir}')
        for entry in entries:
            # print(entry.name)
            name = entry.name
            logging.info(f'moving installer files to {dest_dir_archive}')
            check_archive_files(entry, name)
            logging.info(f'moving installer files to {dest_dir_documents}')
            check_document_files(entry, name)


if __name__ == '__main__':
    main()
