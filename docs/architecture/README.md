# Architecture Diagrams (Excalidraw)

Interactive Excalidraw diagrams for this repository are stored in this directory.

## File Types
- `*.excalidraw`: Native JSON scene data rendered by the embedded canvas.
- `*.excalidraw.svg`: Vector graphic embedding scene metadata (renders natively in GitHub / Markdown).

## Opening in Antigravity IDE / VS Code
1. Install or enable the recommended [`pomdtr.excalidraw-editor`](https://marketplace.visualstudio.com/items?itemName=pomdtr.excalidraw-editor) extension (configured in `.vscode/extensions.json`).
2. Click any `.excalidraw` file in the file explorer to open the interactive visual canvas.

## Command-Line Diagramming (`excalidraw-cli`)
```bash
# View syntax reference, color palettes, and element schemas:
excalidraw ref

# Create a diagram programmatically:
excalidraw create schema.json -o docs/architecture/diagram.excalidraw

# Checkpoint management:
excalidraw cp save v1
excalidraw cp list
```
