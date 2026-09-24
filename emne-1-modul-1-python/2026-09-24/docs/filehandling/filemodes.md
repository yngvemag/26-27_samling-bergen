# File modes

| Mode  | Description |
|-------|-------------|
| `r`   | Opens the file in read-only mode. Starts reading from the beginning of the file and is the default mode for the `open()` function. |
| `rb`  | Opens the file as read-only in binary format and starts reading from the beginning of the file. Binary format is usually used for things like images, videos, etc. |
| `r+`  | Opens a file for reading and writing, placing the pointer at the beginning of the file. |
| `w`   | Opens in write-only mode. The pointer is placed at the beginning of the file, and this will overwrite any existing file with the same name. It will create a new file if one with the same name doesn't exist. |
| `wb`  | Opens a write-only file in binary mode. |
| `w+`  | Opens a file for writing and reading. |
| `wb+` | Opens a file for writing and reading in binary mode. |
| `a`   | Opens a file for appending new information to it. The pointer is placed at the end of the file. A new file is created if one with the same name doesn't exist. |
| `ab`  | Opens a file for appending in binary mode. |
| `a+`  | Opens a file for both appending and reading. |
| `ab+` | Opens a file for both appending and reading in binary mode. |