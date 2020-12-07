# Home Assistant Configuration

[![Home Assistant CI][ha-ci-img]][ha-ci-link] [![Home Assistant Version][ha-version-img]][ha-version-link] [![Uptime Status][ha-uptime-img]][ha-uptime-link] [![Uptime Week][ha-uptime-week-img]][ha-uptime-link]

Configuration files for the awesome [Home Assistant](https://www.home-assistant.io/)

<p align="center">
    <img src="https://github.com/home-assistant/home-assistant-assets/blob/master/misc/loading-screen.gif">
</p>

[Add-ons](https://www.home-assistant.io/addons/):

- [Appdaemon](https://github.com/hassio-addons/addon-appdaemon)
- [Assistant Relay](https://github.com/Apipa169/Assistant-Relay-for-Hassio)
- [Duck DNS](https://github.com/home-assistant/hassio-addons/tree/master/duckdns)
- [ESPHome](https://github.com/esphome/hassio)
- [MariaDB](https://github.com/home-assistant/hassio-addons/tree/master/mariadb)
- [Mosquitto](https://github.com/home-assistant/hassio-addons/tree/master/mosquitto)
- [Node-Red](https://github.com/hassio-addons/addon-node-red)
- [Zigbee2Mqtt](https://github.com/danielwelch/hassio-zigbee2mqtt)

Additional Components:

- [Home Assistant Community Store](https://hacs.xyz/)
- [Home Assistant Plugin for Tasker](https://github.com/MarkAdamson/home-assistant-plugin-for-tasker)
- [IOT Link](https://gitlab.com/iotlink/iotlink)
- [Tuya Convert](https://github.com/ct-Open-Source/tuya-convert)

[ha-ci-img]: https://github.com/RafhaanShah/Home-Assistant-Config/workflows/Home%20Assistant%20CI/badge.svg
[ha-ci-link]: https://github.com/RafhaanShah/Home-Assistant-Config/actions
[ha-version-img]: https://img.shields.io/badge/dynamic/json?color=41bdf5&label=Home%20Assistant&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FRafhaanShah%2FHome-Assistant-Config%2Fmaster%2F.github%2Fversion.json&logo=home-assistant&logoColor=white&cacheSeconds=43200
[ha-version-link]: https://github.com/home-assistant/core/releases
[ha-uptime-img]: https://img.shields.io/uptimerobot/status/m784519564-8bf02c30fb978966db93be1b?label=Uptime%20Robot&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABqlBMVEUAAAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAApjAAoiwAoiwApjAAqjAAoiwA5lRFQoi5Roi45lhIoiwAqjAAqjAAsjQNoq0uOpYN5gXV4gHWNpINqrE4sjgQqjAAqjAAoiwBoq0x/hnwtKy0dHR0dHR0sKix9g3prrFAoiwAqjAA5lRGOpYMtKy0eHh0gIB8fHx4rKiuNo4Q7lhQpjAAoiwBQoi14gHQeHR0gIB8dHRx1fHJTozEoiwAoiwBRoi54gHQdHR0dHRx1fHFUozIoiwApjAA5lhKNpIMsKiwfHx4qKCqNooQ8lxUpiwAqjAAoiwBqrE99g3orKSsdHRwdHRwqKCp6f3htrVIpjAAqjAAsjgRrrE+No4R2fXN1fHKNooNtrVItjgUqjAAoiwA7lhRUozJUpDI8lxUpjAEpjAAoiwAoiwD///9qnxT3AAAAKXRSTlMAAAAAAAEymN/7mDEBBGHe///eYfJhMt3dMpeX3t76l/Le///eMZj7MS7EabIAAAABYktHRI0bDOLVAAAAB3RJTUUH5AMZDTYYuRgLgQAAANFJREFUCNdjYGBkZWPn4OTk4OLmYWJgYObl4xfQ1NLWERTi42VmYBEW0dXTNzA0MjYREWVhEBM3NTO3sLSytrG1k5BkkLJ3cHRydnF1c/fw9JJmkNH09vH18/cPCAwKDpFlkAsNC4/wj4z0j4qOiZVjkIuLT0gEcZOSU1LlGGTS0jMyA/z9s7JzcvNkGaTyCwqLiktKy8orKqvkgRaZVNfU1tU3NDY1Ay0COsOupbWtvaOzWQHoDKAjFZW6unvylFVAjmRg4lFV4+BU51DTAHoBAGl9Lcyvi7VJAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTAzLTI1VDEzOjU0OjI0LTA0OjAwtod7LgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wMy0yNVQxMzo1NDoyNC0wNDowMMfaw5IAAAAASUVORK5CYII=
[ha-uptime-week-img]: https://img.shields.io/uptimerobot/ratio/7/m784519564-8bf02c30fb978966db93be1b?label=Last%20Week&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAOCAMAAAAolt3jAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAABqlBMVEUAAAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAAqjAApjAAoiwAoiwApjAAqjAAoiwA5lRFQoi5Roi45lhIoiwAqjAAqjAAsjQNoq0uOpYN5gXV4gHWNpINqrE4sjgQqjAAqjAAoiwBoq0x/hnwtKy0dHR0dHR0sKix9g3prrFAoiwAqjAA5lRGOpYMtKy0eHh0gIB8fHx4rKiuNo4Q7lhQpjAAoiwBQoi14gHQeHR0gIB8dHRx1fHJTozEoiwAoiwBRoi54gHQdHR0dHRx1fHFUozIoiwApjAA5lhKNpIMsKiwfHx4qKCqNooQ8lxUpiwAqjAAoiwBqrE99g3orKSsdHRwdHRwqKCp6f3htrVIpjAAqjAAsjgRrrE+No4R2fXN1fHKNooNtrVItjgUqjAAoiwA7lhRUozJUpDI8lxUpjAEpjAAoiwAoiwD///9qnxT3AAAAKXRSTlMAAAAAAAEymN/7mDEBBGHe///eYfJhMt3dMpeX3t76l/Le///eMZj7MS7EabIAAAABYktHRI0bDOLVAAAAB3RJTUUH5AMZDTYYuRgLgQAAANFJREFUCNdjYGBkZWPn4OTk4OLmYWJgYObl4xfQ1NLWERTi42VmYBEW0dXTNzA0MjYREWVhEBM3NTO3sLSytrG1k5BkkLJ3cHRydnF1c/fw9JJmkNH09vH18/cPCAwKDpFlkAsNC4/wj4z0j4qOiZVjkIuLT0gEcZOSU1LlGGTS0jMyA/z9s7JzcvNkGaTyCwqLiktKy8orKqvkgRaZVNfU1tU3NDY1Ay0COsOupbWtvaOzWQHoDKAjFZW6unvylFVAjmRg4lFV4+BU51DTAHoBAGl9Lcyvi7VJAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTAzLTI1VDEzOjU0OjI0LTA0OjAwtod7LgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wMy0yNVQxMzo1NDoyNC0wNDowMMfaw5IAAAAASUVORK5CYII=
[ha-uptime-link]: https://stats.uptimerobot.com/y6MVntNroq
