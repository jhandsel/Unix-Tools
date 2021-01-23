# Handling PDFs

## OCR a pdf
```
ocrmypdf in.pdf out.pdf
```

## Split a scanned book into separate pages
```
brew install mupdf
mutool poster -y 2 input.pdf output.pdf
```

## Convert set of images into an OCR'd pdf
```
img2pdf my-images*.jpg | ocrmypdf - myfile.pdf
```

