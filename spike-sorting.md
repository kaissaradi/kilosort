### 🧠 Guía del Pipeline de Análisis de Electrofisiología

Este pipeline procesa datos crudos de electrofisiología combinando corridas experimentales, realizando clasificación de espigas (*spike sorting*) con Kilosort, y opcionalmente ejecutando análisis de post-procesamiento como el promedio disparado por espigas (*spike-triggered average* o STA) para determinar los campos receptivos.

-----



### 📂 Estructura de Archivos

Antes de comenzar, tus datos deben estar organizados con la siguiente estructura. Los scripts dependen de variables de entorno (como `LITKE_PATH`) para encontrar estos directorios.

```
<LITKE_PATH>/
├── h5/
│   └── 20240926C.h5              # Archivo de metadatos del experimento
│
├── raw/
│   └── 20240926C/                # Directorio para las corridas de datos crudos
│       ├── data000/
│       └── data001/
│
├── metadata/
│   └── json/
│       └── 20240926C.json        # Autogenerado desde el archivo .h5
│
└── sorted/
    └── 20240926C/                # Ubicación de salida para todos los datos procesados
```

-----

### 🚀 Flujos de Trabajo Principales
Primero debes guardar los datos crudos del ordenador del rig (h5file y raw data) dentro de la carpeta 'data'. AHi encontraras dos subcarpetas h5 y raw donde deben ir ambos archivos.
Estas son las formas principales de usar el pipeline.

Depues debes abrir 'terminal'

#### 1\. Combinar Corridas de Datos Crudos

Cada directorio de datos crudos (p. ej., `data000`) representa una única corrida de estímulo. Usa el script `prepare_data.sh` para fusionar múltiples corridas en un solo archivo `.bin` continuo para una clasificación de espigas combinada.

**Cómo ejecutarlo:**
Este comando combina `data005`, `data006` y `data010` en un solo bloque (*chunk*) llamado `chunk2`.

```bash
bash prepare_data.sh 20220531C chunk2 data005 data006 data010 -s 4
```

-----

#### 2\. Ejecutar Solo la Clasificación de Espigas (*Spike Sorting*)

Si solo necesitas clasificar espigas y no necesitas calcular los campos receptivos, ejecuta el script principal `pipeline.sh`. La clave es **omitir la bandera `-n`**, que le indica al pipeline que se salte el paso de análisis STA. Aún debes especificar qué archivos clasificar usando la bandera `-f`.

**Cómo ejecutarlo:**
Esto clasifica un bloque (*chunk*) compuesto por `data000`, `data001` y `data002` sin realizar ningún análisis posterior.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000" -a 60 -s 4
```

-----

#### 3\. Ejecutar Análisis Completo (*Spike Sorting* + STA)
Asegurate siempre que el nombre de 'chunk' debe ser siempre un numero superior al de 'data'. Por ejemplo chunk1 debe ser data000. 
Para realizar tanto la clasificación de espigas como el análisis de campos receptivos, **debes** especificar qué corrida de datos contiene el estímulo requerido (típicamente una grabación de ruido blanco). Usa la bandera `-n` para apuntar a este "archivo de ruido" (*noise file*).

  * `-f <archivos>`: Define **todos** los archivos que se combinarán y clasificarán juntos.
  * `-n <archivo_ruido>`: Define el archivo **específico** que se usará para el cálculo de STA.

**Cómo ejecutarlo:**
Este comando clasifica las espigas de tres corridas de datos y luego usa `data000` para calcular los campos receptivos.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000" -n "data000" e- "data000" -a 60 -s 4
```

-----

#### 4\. Ejecutar Solo el Análisis STA

Si tus datos ya han sido clasificados (*spike-sorted*) y quieres ejecutar o re-ejecutar el análisis STA, usa el script `analyze_chunk.sh` directamente. Esto es útil para probar diferentes protocolos de análisis sin tener que volver a clasificar.

**Cómo ejecutarlo:**
Este comando ejecuta el análisis STA sobre los resultados existentes de `kilosort2.5` para `chunk1`, usando `data000` como la fuente de ruido. El `0.6` es el `CROP_FRACTION`, un parámetro determinado por el espaciado de la matriz de electrodos (*array*). Para usar un protocolo de análisis diferente, puedes establecer la variable de entorno `PROT` de antemano.

```bash
# Opcional: Establecer un protocolo diferente
export PROT='AdaptNoiseColorSteps'

# Ejecutar el análisis
bash analyze_chunk.sh 20240926C chunk1 kilosort2.5 0.6 data000 -s 4
```

-----

### 🛠️ Opciones Completas del Pipeline

El script `pipeline.sh` es el controlador principal y acepta varias opciones para personalizar el flujo de trabajo.

| Bandera | Argumento | Descripción |
| :--- | :--- | :--- |
| `-f` | `<chunk_files>` | **(Requerido)** Los archivos de datos a combinar y clasificar. Puede ser una lista separada por espacios o un rango (p. ej., `"0-10,15"`). |
| `-n` | `<noise_files>` | Archivos de datos a usar para el cálculo de campos receptivos (RF). Si se omite, este paso no se ejecuta. |
| `-e` | `<ei_files>` | Archivos de datos usados para el cálculo de la imagen eléctrica (EI) y la deduplicación. |
| `-a` | `<array_spacing>` | El espaciado de la matriz de electrodos en micrones (`30`, `60` o `120`). El valor por defecto es `60`. |
| `-s` | `<sort_algorithms>` | Una lista separada por espacios de las versiones de Kilosort a ejecutar (p. ej., `"2.5 4"`). El valor por defecto es `"2.5"`. |
| `-t` | `<threads>` | El número de hilos (threads) del CPU para el procesamiento. El valor por defecto es `8`. |
| `-p` | `<protocol>` | El protocolo de análisis para el cálculo de RF. El valor por defecto es `SpatialNoise`. |
| `-c` | | Una bandera para habilitar la referencia de promedio común (CAR). Deshabilitado por defecto. |
| `-h` | | Muestra el mensaje de ayuda. |

### 🧠 Electrophysiology Analysis Pipeline Guide

This pipeline processes raw electrophysiology data by combining experimental runs, performing spike sorting with Kilosort, and optionally running post-processing analyses like spike-triggered average (STA) to determine receptive fields.

-----

### 📂 File Structure

Before you begin, your data must be organized in the following structure. The scripts rely on environment variables (like `LITKE_PATH`) to find these directories.

```
<LITKE_PATH>/
├── h5/
│   └── 20240926C.h5              # Experiment metadata file
│
├── raw/
│   └── 20240926C/                # Directory for raw data runs
│       ├── data000/
│       └── data001/
│
├── metadata/
│   └── json/
│       └── 20240926C.json        # Auto-generated from the .h5 file
│
└── sorted/
    └── 20240926C/                # Output location for all processed data
```

-----

### 🚀 Core Workflows

Here are the primary ways to use the pipeline.

#### 1\. Combine Raw Data Runs

Each raw data directory (e.g., `data000`) represents a single stimulus run. Use the `prepare_data.sh` script to merge multiple runs into one continuous `.bin` file for combined spike sorting.

**How to Run It:**
This command combines `data005`, `data006`, and `data010` into a single chunk named `chunk2`.

```bash
bash prepare_data.sh 20220531C chunk2 data005 data006 data010
```

-----

#### 2\. Run Spike Sorting Only

If you only need to sort spikes and do not need to calculate receptive fields, run the main `pipeline.sh` script. The key is to **omit the `-n` flag**, which tells the pipeline to skip the STA analysis step. You must still specify which files to sort using the `-f` flag.

**How to Run It:**
This sorts a chunk made of `data000`, `data001`, and `data002` without performing any analysis afterward.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000 data001 data002" -a 60
```

-----

#### 3\. Run Full Analysis (Spike Sorting + STA)

To perform both spike sorting and receptive field analysis, you **must** specify which data run contains the required stimulus (typically a white noise recording). Use the `-n` flag to point to this "noise file".

  * `-f <files>`: Defines **all** files to be combined and sorted together.
  * `-n <noise_file>`: Defines the **specific** file used for the STA calculation.

**How to Run It:**
This command sorts spikes from three data runs and then uses `data000` to calculate the receptive fields.

```bash
bash pipeline.sh 20240926C chunk1 -f "data000 data001 data002" -n "data000" -a 60
```

-----

#### 4\. Run STA Analysis Only

If your data is already spike-sorted and you want to run or re-run the STA analysis, use the `analyze_chunk.sh` script directly. This is useful for testing different analysis protocols without re-sorting.

**How to Run It:**
This command runs STA analysis on the existing `kilosort2.5` results for `chunk1`, using `data000` as the noise source. The `0.6` is the `CROP_FRACTION`, a parameter determined by array spacing. To use a different analysis protocol, you can set the `PROT` environment variable beforehand.

```bash
# Optional: Set a different protocol
export PROT='AdaptNoiseColorSteps'

# Run the analysis
bash analyze_chunk.sh 20240926C chunk1 kilosort2.5 0.6 data000
```

-----

### 🛠️ Full Pipeline Options

The `pipeline.sh` script is the main driver and accepts several options to customize the workflow.

| Flag | Argument | Description |
| :--- | :--- | :--- |
| `-f` | `<chunk_files>` | **(Required)** The data files to be combined and sorted. Can be a space-separated list or a range (e.g., `"0-10,15"`). |
| `-n` | `<noise_files>` | Data files to use for receptive field (RF) calculation. If omitted, this step is skipped. |
| `-e` | `<ei_files>` | Data files used for electrical image (EI) calculation and deduplication. |
| `-a` | `<array_spacing>` | The electrode array spacing in microns (`30`, `60`, or `120`). Defaults to `60`. |
| `-s` | `<sort_algorithms>` | A space-separated list of Kilosort versions to run (e.g., `"2.5 4"`). Defaults to `"2.5"`. |
| `-t` | `<threads>` | The number of CPU threads for processing. Defaults to `8`. |
| `-p` | `<protocol>` | The analysis protocol for RF calculation. Defaults to `SpatialNoise`. |
| `-c` | | A flag to enable common average referencing (CAR). Disabled by default. |
| `-h` | | Displays the help message. |
