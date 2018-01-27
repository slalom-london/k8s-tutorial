# Swap out your secrets (do not commit to source control!!!)
# Run this script in the same directory as  your .travis.yml
travis encrypt-file build-scripts/large-secrets.txt
mv large-secrets.txt.enc build-scripts/large-secrets.txt.enc
travis encrypt KUBE_PASSWORD="[your kube password here]" --add
travis encrypt AWS_KEY="[your aws key here]" --add
travis encrypt AWS_SECRET_KEY="[your aws secret key here]" --add
