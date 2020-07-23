c.JupyterHub.spawner_class = 'dockerspawner.DockerSpawner'
c.DockerSpawner.image = 'jupyter/datascience-notebook:latest'
from jupyter_client.localinterfaces import public_ips
c.JupyterHub.hub_ip = public_ips()[0]
c.DockerSpawner.name_template = "{prefix}-{username}-{servername}"

# Explicitly set notebook directory because we'll be mounting a host volume to
# it.  
notebook_dir = '/home/jovyan/work'
c.DockerSpawner.notebook_dir = notebook_dir

# Mount the user's Docker volume on the host to the notebook user's
# notebook directory in the container
c.DockerSpawner.volumes = { 'jupyterhub-user-{username}': notebook_dir }

# Remove containers once they are stopped
c.DockerSpawner.remove_containers = True
