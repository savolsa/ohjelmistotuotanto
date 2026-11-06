from urllib import request
from project import Project
import toml


class ProjectReader:
    def __init__(self, url):
        self._url = url

    def get_project(self):
        content = request.urlopen(self._url).read().decode("utf-8")

        data = toml.loads(content)

        project_data = data["project"]

        name = project_data["name"]
        description = project_data.get("description", "")

        dependencies = [
            dependency.split(">=")[0]
            for dependency in project_data.get("dependencies", [])
        ]

        development_dependencies = [
            dependency.split(">=")[0]
            for dependency in data.get("dependency-groups", {}).get("dev", [])
        ]

        license = project_data.get("license", {}).get("text", "-") if isinstance(project_data.get("license"), dict) else project_data.get("license", "-")

        authors = [
            author["name"] for author in project_data.get("authors", [])
        ]

        return Project(
            name,
            description,
            dependencies,
            development_dependencies,
            license,
            authors
        )