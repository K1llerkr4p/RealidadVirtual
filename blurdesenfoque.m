function blurdesenfoque()
    % Cargar la imagen
    imagen = imread('gatomamado.jpg');

    % Mostrar la imagen original
    figure;
    imshow(imagen);
    title('Imagen Original');

    % Si la imagen está en color, convertir a escala de grises
    if size(imagen, 3) == 3
        imagen_gris = rgb2gray(imagen);
    else
        imagen_gris = imagen;  % Si ya está en escala de grises, no se hace nada
    end

    % Aplicar filtro de desenfoque (Blur)
    kernel_blur = fspecial('gaussian', [5 5], 2);  % Kernel Gaussiano
    imagen_blur = filtroBlur(imagen_gris, kernel_blur);

    % Mostrar la imagen desenfocada
    figure;
    imshow(imagen_blur);
    title('Imagen con Filtro Blur (Desenfoque)');

    % Aplicar filtro de detección de bordes (Sobel)
    kernel_bordes = fspecial('sobel');  % Kernel de Sobel
    imagen_bordes = filtroBordes(imagen_gris, kernel_bordes);

    % Mostrar la imagen con bordes detectados
    figure;
    imshow(imagen_bordes);
    title('Imagen con Detección de Bordes');
end

% Función para aplicar el filtro Blur (desenfoque)
function imagen_filtrada = filtroBlur(imagen, kernel)
    % Esta función aplica un filtro de desenfoque (Blur) a una imagen.
    % Entradas:
    %   imagen: La imagen a la cual se le aplicará el filtro.
    %   kernel: El kernel que se utilizará para el filtro de desenfoque.
    % Salida:
    %   imagen_filtrada: La imagen resultante después de aplicar el filtro.

    % Aplicar el filtro utilizando la función imfilter
    imagen_filtrada = imfilter(imagen, kernel, 'conv', 'same', 'replicate');
end

% Función para aplicar el filtro de detección de bordes
function imagen_bordes = filtroBordes(imagen, kernel)
    % Esta función aplica un filtro de detección de bordes a una imagen.
    % Entradas:
    %   imagen: La imagen a la cual se le aplicará el filtro.
    %   kernel: El kernel que se utilizará para la detección de bordes.
    % Salida:
    %   imagen_bordes: La imagen resultante con los bordes detectados.

    % Aplicar el filtro utilizando la función imfilter
    imagen_bordes = imfilter(imagen, kernel, 'conv', 'same', 'replicate');
end
