# Heroku buildback for DC project

# How to use:
1. `heroku buildpacks:clear` if necessary
2. `heroku buildpacks:set https://github.com/castamir/buildpack-dc`
3. `heroku config:set FE_PROJECT_PATH=projects/nodejs/frontend` pointing to a frontend project root.
4. `heroku config:set BE_PROJECT_PATH=projects/nodejs/backend` pointing to a backend project root.
5. `heroku config:set TARGET_PATH=target` pointing to a folder, where to move frontend project (in this case to `projects/nodejs/backend/target`)
6. Deploy your project to Heroku.

# How it works
The buildpack takes subdirectory you configured as `BE_PROJECT_PATH`, copies `FE_PROJECT_PATH` into it under `TARGET_PATH` subdirectory, erases everything else, and copies that `BE_PROJECT_PATH` directory to project root. Then normal Heroku slug compilation proceeds.
