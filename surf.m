
imagenes = {'gatomamado.jpg', 'pinguino.jpg', 'tiburon.jpg'}; % Lista de imágenes
num_imagenes = length(imagenes);

descriptores_objetos = [];
puntos_objetos = [];

for i = 1:num_imagenes
    % Leer la imagen
    imagen = imread(imagenes{i});
    
    if size(imagen, 3) == 3
        imagen = rgb2gray(imagen);
    end
    
    puntos_SURF = detectSURFFeatures(imagen);
    
    [descriptores, puntos] = extractFeatures(imagen, puntos_SURF);
    
    descriptores_objetos = [descriptores_objetos; descriptores];
    puntos_objetos = [puntos_objetos; puntos.Location]; % Guardar solo la ubicación de los puntos
end

disp('Puntos característicos extraídos de las imágenes de entrenamiento.');

nueva_imagen = imread('gatomamado.jpg');
if size(nueva_imagen, 3) == 3
    nueva_imagen = rgb2gray(nueva_imagen);
end

puntos_SURF_nueva = detectSURFFeatures(nueva_imagen);

[descriptores_nueva, puntos_nueva] = extractFeatures(nueva_imagen, puntos_SURF_nueva);

indice_coincidencias = matchFeatures(descriptores_objetos, descriptores_nueva);

puntos_coincidencia_objetos = puntos_nueva(indice_coincidencias(:, 2), :);

if ~isempty(puntos_coincidencia_objetos)
    disp('El objeto ha sido encontrado en la nueva imagen.');
    figure;
    imshow(nueva_imagen); hold on;
    plot(puntos_coincidencia_objetos.selectStrongest(10), 'showOrientation', true);
    title('Puntos coincidentes encontrados en la nueva imagen');
else
    disp('El objeto no se encuentra en la nueva imagen.');
end
