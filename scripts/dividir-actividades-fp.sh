#!/bin/bash

# Configuración
ORGANIZACION="IES-Torrevigia-FP"
MONOREPO="curso-git-actividades"
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_DIR=$(cd "$SCRIPT_DIR/../.." && pwd)
RUTA_ACTUAL="$ROOT_DIR"

echo "🚀 Iniciando división de actividades para $ORGANIZACION"
echo "📁 Monorepo: $MONOREPO"
echo "-----------------------------------"

# Verificar que existe el monorepo
if [ ! -d "$ROOT_DIR/$MONOREPO" ]; then
    echo "❌ No encuentro la carpeta $MONOREPO"
    echo "Asegúrate de que el script está en la misma carpeta que tu monorepo"
    exit 1
fi

cd "$ROOT_DIR" || exit 1

# Crear archivo de resumen
echo "📊 Creando archivo de resumen..."
echo "ACTIVIDADES CREADAS - $(date)" > actividades-creadas.txt
echo "==================================" >> actividades-creadas.txt

# Procesar actividades del 1 al 33
for i in $(seq -f "%03g" 1 33); do
    ARCHIVO="actividad_6_${i}.md"
    ACTIVIDAD_NOMBRE="actividad_6_${i}"
    REPO_NOMBRE="${ACTIVIDAD_NOMBRE}-template"
    
    echo ""
    echo "📌 Procesando $ARCHIVO ($i de 33)"
    
    # Verificar que el archivo existe
    if [ ! -f "$MONOREPO/$ARCHIVO" ]; then
        echo "⚠️  Archivo $ARCHIVO no encontrado, continuando..."
        echo "❌ $ARCHIVO - NO ENCONTRADO" >> actividades-creadas.txt
        continue
    fi
    
    # Crear repositorio temporal
    if [ -d "$REPO_NOMBRE" ]; then
        echo "⚠️  La carpeta $REPO_NOMBRE ya existe, la omito para evitar sobrescribir"
        echo "⚠️  $REPO_NOMBRE - CARPETA YA EXISTE" >> actividades-creadas.txt
        continue
    fi

    mkdir "$REPO_NOMBRE"
    cd "$REPO_NOMBRE" || exit 1
    
    git init
    git config user.name "GitHub Classroom Bot"
    git config user.email "classroom@github.com"
    
    # Copiar el archivo y crear estructura
    cp "../$MONOREPO/$ARCHIVO" .
    
    # Crear un README básico para la actividad
    cat > README.md << EOF
# ${ACTIVIDAD_NOMBRE}

Esta es la actividad ${i} del curso.

## Instrucciones
Completa los ejercicios en \`${ARCHIVO}\`.

## Entrega
Sigue las instrucciones de GitHub Classroom para esta actividad.
EOF
    
    # Hacer commit
    git add .
    git commit -m "Initial commit: ${ACTIVIDAD_NOMBRE}"
    
    # Crear repositorio en GitHub (necesitas GitHub CLI instalado)
    echo "Creando repositorio $REPO_NOMBRE en GitHub..."
    
    # Intentar crear repositorio con GitHub CLI
    if command -v gh &> /dev/null; then
        if gh repo view "$ORGANIZACION/$REPO_NOMBRE" >/dev/null 2>&1; then
            echo "⚠️  El repositorio $REPO_NOMBRE ya existe en GitHub, omitiendo creación"
            echo "⚠️  $REPO_NOMBRE - YA EXISTE EN GITHUB" >> ../actividades-creadas.txt
            cd ..
            echo "-----------------------------------"
            sleep 1
            continue
        fi

        gh repo create "$ORGANIZACION/$REPO_NOMBRE" --public --source=. --remote=origin --push
        if [ $? -eq 0 ]; then
            echo "✅ Repositorio creado: https://github.com/$ORGANIZACION/$REPO_NOMBRE"
            echo "✅ $REPO_NOMBRE" >> ../actividades-creadas.txt
        else
            echo "❌ Error al crear repositorio para $ACTIVIDAD_NOMBRE"
            echo "❌ $REPO_NOMBRE - ERROR AL CREAR" >> ../actividades-creadas.txt
        fi
    else
        echo "⚠️  GitHub CLI no encontrado. Por favor, instala gh o crea manualmente:"
        echo "   https://github.com/$ORGANIZACION/$REPO_NOMBRE"
        echo "📋 Instrucciones manuales:" >> ../actividades-manuales.txt
        echo "cd $RUTA_ACTUAL/$REPO_NOMBRE" >> ../actividades-manuales.txt
        echo "git remote add origin https://github.com/$ORGANIZACION/$REPO_NOMBRE.git" >> ../actividades-manuales.txt
        echo "git push -u origin main" >> ../actividades-manuales.txt
        echo "" >> ../actividades-manuales.txt
    fi
    
    cd ..
    
    echo "✅ Actividad ${i} procesada"
    echo "-----------------------------------"
    
    # Pequeña pausa para no saturar la API de GitHub
    sleep 1
done

echo ""
echo "🎉 ¡Proceso completado!"
echo "📄 Revisa actividades-creadas.txt para ver el resumen"

if [ -f actividades-manuales.txt ]; then
    echo "📋 Se ha creado actividades-manuales.txt con instrucciones para crear repositorios manualmente"
fi

echo ""
echo "🔄 Ahora, configurando repositorios como templates..."

# Configurar como template (si tenemos gh)
if command -v gh &> /dev/null; then
    for i in $(seq -f "%03g" 1 33); do
        REPO_NOMBRE="actividad_6_${i}-template"
        echo "Configurando $REPO_NOMBRE como template..."

        if ! gh repo view "$ORGANIZACION/$REPO_NOMBRE" >/dev/null 2>&1; then
            echo "⚠️  El repositorio $REPO_NOMBRE no existe, omitiendo"
            sleep 0.5
            continue
        fi
        
        gh api -X PATCH "repos/$ORGANIZACION/$REPO_NOMBRE" -f is_template=true
        
        if [ $? -eq 0 ]; then
            echo "✅ $REPO_NOMBRE configurado como template"
        else
            echo "❌ Error al configurar $REPO_NOMBRE"
        fi
        
        sleep 0.5
    done
else
    echo ""
    echo "⚠️  Para configurar como template manualmente:"
    echo "1. Ve a cada repositorio en GitHub"
    echo "2. Entra en Settings > Template repository"
    echo "3. Marca la casilla 'Template repository'"
fi

echo ""
echo "📝 PRÓXIMOS PASOS:"
echo "1. Ve a https://classroom.github.com"
echo "2. Crea la primera tarea manualmente con actividad_6_001-template"
echo "3. Para las demás, usa 'Reutilizar tarea' cambiando el template"
echo ""
echo "🎯 ¡Todo listo para configurar las 33 actividades en GitHub Classroom!"