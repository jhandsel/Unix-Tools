# Handling PDFs

### OCR a pdf
```
ocrmypdf in.pdf out.pdf
```
With lossy compression:
```
ocrmypdf --optimize 2 in.pdf out.pdf
```
Use `--optimize 2` for aggressive lossy compression.

### Redo OCR on a pdf
```
ocrmypdf --redo-ocr in.pdf out.pdf
```
If that gives poor output, try
```
ocrmypdf --force-ocr in.pdf out.pdf
```
This rasterizes everything and re-ocrs.

## Clean, deskew and ocr
Cleans before OCR, but not final output
```
ocrmypdf --force-ocr --deskew --clean in.pdf out.pdf
```
Remove background on output (only for grayscale), can delete images
```
ocrmypdf --force-ocr --deskew --clean --remove-background in.pdf out.pdf
```
As above, but clean final output
```
ocrmypdf --force-ocr --deskew --clean --clean-final --remove-background in.pdf out.pdf
```

### Split a scanned book into separate pages
```
brew install mupdf
mutool poster -y 2 input.pdf output.pdf
```

### Convert set of images into an OCR'd pdf
```
img2pdf my-images*.jpg | ocrmypdf - myfile.pdf
```
