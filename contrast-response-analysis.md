
### 🧠 Guía Sencilla de MATLAB

Esta es una guía paso a paso para cargar tus datos y crear una gráfica en MATLAB.

-----

### ¿Qué Contiene el Archivo MAT?

El archivo **`kilosort4_contrastResponse.mat`** es un archivo de datos de MATLAB que contiene los resultados de tu experimento. Dentro de él, las variables más importantes son:

  * **`avg_response`**: La tasa de disparo promedio de cada neurona para cada condición de estímulo.
  * **`cluster_id`**: Una lista de los números de ID únicos para tus neuronas.
  * **`u_contrast`**: Una lista de los niveles de contraste específicos que se probaron (p. ej., 0.1, 0.2, 0.4).
  * **`u_radius`**: Una lista de los diferentes tamaños de punto (*spot*) que se usaron.

-----

### Pasos para Graficar en MATLAB

#### Paso 1: Abrir MATLAB y Cargar los Datos

Primero, asegúrate de que el archivo `.mat` esté en la carpeta actual que MATLAB está usando.

1.  **Encuentra la "Command Window"** (Ventana de Comandos). Aquí es donde escribirás los comandos.
2.  **Escribe el siguiente comando** y presiona **Enter**. Esto carga tu archivo en una variable llamada `data`.

<!-- end list -->

```matlab
data = load('kilosort4_contrastResponse.mat');
```

Después de ejecutar esto, verás la variable `data` en tu panel de "Workspace".

-----

#### Paso 2: Copiar y Pegar el Código para Graficar

Ahora, copia el bloque de código completo de abajo y pégalo directamente en la **Command Window**. Presiona **Enter** para ejecutarlo. Este código creará la gráfica para la segunda neurona de tu conjunto de datos.

```matlab
% --- Código para Graficar la Función de Respuesta al Contraste ---

% 1. Elige qué neurona analizar (1 es la primera, 2 la segunda, etc.)
neuron_to_plot = 2;

% 2. Extraer los datos que necesitamos del contenedor 'data' que cargamos
contrast_levels = data.u_contrast;
all_responses = data.avg_response;

% 3. Obtener la curva de respuesta específica para la neurona elegida
% Nota: Estamos seleccionando los datos para el primer radio y la primera frecuencia temporal
neuron_response_curve = squeeze(all_responses(neuron_to_plot, :, 1, 1));

% 4. Crear la gráfica
figure; % Crea una nueva ventana para la figura
plot(contrast_levels, neuron_response_curve, 'o-'); % Grafica los datos con marcadores y una línea

% 5. Añadir etiquetas para que la gráfica sea clara
xlabel('Nivel de Contraste');
ylabel('Respuesta Promedio (espigas/s)');
title(sprintf('Función de Respuesta al Contraste para Neurona %d', data.cluster_id(neuron_to_plot)));
grid on; % Añade una cuadrícula para facilitar la lectura

disp('✅ ¡Gráfica creada con éxito!');
```

Aparecerá una nueva ventana con tu gráfica. Puedes cambiar el número de `neuron_to_plot` en la primera línea del código para ver los resultados de otras neuronas.



### What the MAT File Contains

The `kilosort4_contrastResponse.mat` file is a standard MATLAB data file that contains your experiment's results saved in a dictionary-like structure. Think of it as a container holding several variables, each with a specific name (key) and data. The most important variables are:

  * **`avg_response`**: The average firing rate of each neuron for every stimulus condition.
  * **`cluster_id`**: A list of the unique ID numbers for your neurons.
  * **`u_contrast`**: A list of the specific contrast levels that were tested (e.g., 0.1, 0.2, 0.4).
  * **`u_radius`**: A list of the different spot sizes that were used.

-----

### Simple MATLAB Guide for Non-Coders

This is a step-by-step guide to create the same plot you made in Python, but using MATLAB instead.

#### Step 1: Open MATLAB and Load the Data

First, make sure the `.mat` file is in the current folder that MATLAB is looking at.

1.  **Find the "Command Window"** in MATLAB. This is where you will type commands.
2.  **Type the following command** and press **Enter**. This loads your file and puts all the variables into a single container called `data`.

<!-- end list -->

```matlab
data = load('kilosort4_contrastResponse.mat');
```

After you run this, you will see a new variable named `data` in your "Workspace" panel.

#### Step 2: Copy and Paste the Plotting Code

Now, copy the entire code block below and paste it directly into the Command Window. Press **Enter** to run it.

This code will automatically create a plot of the contrast response function for the second neuron in your dataset.

```matlab
% --- Code to Plot Contrast Response Function ---

% 1. Choose which neuron to look at (1 is the first, 2 is the second, etc.)
neuron_to_plot = 2;

% 2. Extract the data we need from the loaded 'data' container
contrast_levels = data.u_contrast;
all_responses = data.avg_response;

% 3. Get the specific response curve for our chosen neuron
% Note: We are selecting the data for the first radius and first temporal frequency
neuron_response_curve = squeeze(all_responses(neuron_to_plot, :, 1, 1));

% 4. Create the plot
figure; % Creates a new figure window
plot(contrast_levels, neuron_response_curve, 'o-'); % Plots the data with markers and a line

% 5. Add labels to make the plot clear
xlabel('Contrast Level');
ylabel('Average Response (spikes/s)');
title(sprintf('Contrast Response Function for Neuron %d', data.cluster_id(neuron_to_plot)));
grid on; % Adds a grid for easier reading

disp('✅ Plot created successfully!');
```

A new window will pop up showing your contrast response function plot, just like the one you created before. You can change the `neuron_to_plot` number in the first line of the code to see the results for different neurons.
