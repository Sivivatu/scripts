import os
import logging
from shutil import move


# ! FILL IN BELOW
# ? folder to track e.g. Windows: "C:\\Users\\UserName\\Downloads"
source_dir = 'C:\\Users\\paulj\\Downloads'
dest_dir_installers = os.path.join(source_dir, 'Installers')
dest_dir_music = os.path.join(source_dir, 'music')
dest_dir_video = os.path.join(source_dir, 'video')
dest_dir_image = os.path.join(source_dir, 'image')
dest_dir_documents = os.path.join(source_dir, 'documents')

# ? supported image types
image_extensions = [".jpg", ".jpeg", ".jpe", ".jif", ".jfif", ".jfi", ".png", ".gif", ".webp", ".tiff", ".tif", ".psd", ".raw", ".arw", ".cr2", ".nrw",
                    ".k25", ".bmp", ".dib", ".heif", ".heic", ".ind", ".indd", ".indt", ".jp2", ".j2k", ".jpf", ".jpf", ".jpx", ".jpm", ".mj2", ".svg", ".svgz", ".ai", ".eps", ".ico"]
# ? supported Video types
video_extensions = [".webm", ".mpg", ".mp2", ".mpeg", ".mpe", ".mpv", ".ogg",
                    ".mp4", ".mp4v", ".m4v", ".avi", ".wmv", ".mov", ".qt", ".flv", ".swf", ".avchd"]
# ? supported Audio types
audio_extensions = [".m4a", ".flac", "mp3", ".wav", ".wma", ".aac"]
# ? supported Document types
document_extensions = [".doc", ".docx", ".odt",
                       ".pdf", ".xls", ".xlsx", ".ppt", ".pptx"]

installer_extensions = [".exe"]


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


def move_file(dest, entry, name):
    if os.path.exists(f"{dest}/{name}"):
        unique_name = make_unique(name)
        os.rename(entry, unique_name)
    move(entry, dest)

def check_installer_files(entry, name):  # * Checks all Video Files
    for installer_extension in installer_extensions:
        if name.endswith(installer_extension) or name.endswith(installer_extension.upper()):
            move_file(dest_dir_installers, entry, name)
            logging.info(f"Moved installer file: {name}")


def check_document_files(entry, name):  # * Checks all Video Files
    for document_extension in document_extensions:
        if name.endswith(document_extension) or name.endswith(document_extension.upper()):
            move_file(dest_dir_documents, entry, name)
            logging.info(f"Moved document file: {name}")

            # self.check_audio_files(entry, name)
            # self.check_video_files(entry, name)
            # self.check_image_files(entry, name)
            # self.check_document_files(entry, name)


def main():
    with os.scandir(source_dir) as entries:
        logging.info(f'checking files in {source_dir}')
        for entry in entries:
            # print(entry.name)
            name = entry.name
            # logging.info(f'moving installer files')
            check_installer_files(entry, name)
            check_document_files(entry, name)
    


if __name__ == '__main__':
    main()