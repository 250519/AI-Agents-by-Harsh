#!/bin/bash

echo "🚀 Checking for existing SSH key..."

if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
  echo "✅ SSH key exists!"
else
  echo "🔐 No SSH key found. Generating one..."
  ssh-keygen -t rsa -b 4096 -C "your-email@example.com" -f "$HOME/.ssh/id_rsa" -N ""
fi

echo "🧠 Starting ssh-agent and adding key..."
eval "$(ssh-agent -s)"
ssh-add "$HOME/.ssh/id_rsa"

echo "📋 Copying SSH key to clipboard (paste it in GitHub)..."
pbcopy < "$HOME/.ssh/id_rsa.pub"
echo "✅ SSH key copied to clipboard!"
echo "👉 Go to https://github.com/settings/ssh/new and paste it as a new key (call it MacBook Air)"

read -p "🔁 Press [Enter] once you've added the SSH key to GitHub..."

echo "🔄 Updating Git remote to use SSH..."
git remote set-url origin git@github.com:250519/AI-Agents-by-Harsh.git

echo "🧪 Verifying remote URL:"
git remote -v

echo "📤 Pushing to GitHub via SSH..."
git push -u origin main

echo "🎉 All done! Your push should now work without SSL errors."


