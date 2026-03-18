#!/bin/bash

echo "🔍 Veuillez entrer l'URL du repository bancaire à cloner :"
read repo_url

if [ -n "$repo_url" ]; then
    echo "📦 Clonage du repository dans src/..."
    cd src
    git clone $repo_url .
    echo "✅ Repository cloné avec succès!"
else
    echo "❌ URL non fournie. Veuillez cloner manuellement le code dans src/"
fi
