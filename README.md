# Home Assistant Configuration

[![Home Assistant CI][ha-ci-img]][ha-ci-link] [![Home Assistant Version][ha-version-img]][ha-version-link] [![Uptime Status][ha-uptime-img]][ha-uptime-link] [![Uptime Week][ha-uptime-week-img]][ha-uptime-link]

Configuration files for the awesome [Home Assistant](https://www.home-assistant.io/)

<p align="center">
    <img src="https://github.com/home-assistant/home-assistant-assets/blob/master/misc/loading-screen.gif">
</p>

## Installation / Hardware:

Currently using [Home Assistant OS](https://www.home-assistant.io/hassio/installation/) installed in a virtual machine in [Proxmox](https://proxmox.com/en/), running on a mini-pc from [AliExpress](https://www.aliexpress.com/item/32869744040.html)

- CPU: [Intel i3-7020U](https://ark.intel.com/content/www/us/en/ark/products/122590/intel-core-i3-7020u-processor-3m-cache-2-30-ghz.html)
- Memory: [Crucial](https://uk.crucial.com/memory/eol_ddr4/ct8g4sfs8266) 2x8GB DDR4 2666 MT/s
- SSD: 256GB [Sabrent Rocket NVMe](https://www.sabrent.com/product/SB-ROCKET-256/256gb-rocket-nvme-pcie-m-2-2280-internal-ssd-high-performance-solid-state-drive/)
- HDD: 8 TB [WD My Book USB 3.0](https://shop.westerndigital.com/en-gb/products/external-drives/wd-my-book-usb-3-0-hdd#WDBBGB0080HBK-EESN)
- Wi-Fi: [Intel Wireless-N 7260](https://ark.intel.com/content/www/us/en/ark/products/75174/intel-wireless-n-7260.html)
- LAN: 1x Intel I219-LM, 1x Realtek RTL8168/8111/8112

## GUI [Integrations](https://www.home-assistant.io/integrations/):

- [Blink](https://www.home-assistant.io/integrations/blink)
- [Broadlink](https://www.home-assistant.io/integrations/broadlink)
- [ESPHome](https://www.home-assistant.io/integrations/esphome/)
- [Google Cast](https://www.home-assistant.io/integrations/cast)
- [Hacs](https://hacs.xyz/docs/configuration/start)
- [Mobile App](https://www.home-assistant.io/integrations/mobile_app/)
- [MQTT](https://www.home-assistant.io/integrations/mqtt)
- [Philips Hue](https://www.home-assistant.io/integrations/hue)
- [Pi-hole](https://www.home-assistant.io/integrations/pi_hole)
- [Spotify](https://www.home-assistant.io/integrations/spotify)
- [UPnP](https://www.home-assistant.io/integrations/upnp)

## [Add-ons](https://www.home-assistant.io/addons/):

- [Assistant Relay](https://github.com/Apipa169/Assistant-Relay-for-Hassio)
- [Check Config](https://github.com/home-assistant/addons/tree/master/check_config)
- [Duck DNS](https://github.com/home-assistant/hassio-addons/tree/master/duckdns)
- [ESPHome](https://github.com/esphome/hassio)
- [File Editor](https://github.com/home-assistant/addons/tree/master/configurator)
- [Google Drive Backup](https://github.com/sabeechen/hassio-google-drive-backup)
- [MariaDB](https://github.com/home-assistant/hassio-addons/tree/master/mariadb)
- [Mosquitto](https://github.com/home-assistant/hassio-addons/tree/master/mosquitto)
- [Node-Red](https://github.com/hassio-addons/addon-node-red)
- [Portainer](https://github.com/hassio-addons/addon-portainer)
- [SSH & Web Terminal](https://github.com/hassio-addons/addon-ssh)
- [Samba Share](https://github.com/home-assistant/addons/tree/master/samba)
- [Zigbee2Mqtt](https://github.com/danielwelch/hassio-zigbee2mqtt)

## Custom Components:

- [Adaptive Lighting](https://github.com/basnijholt/adaptive-lighting)
- [Eufy RoboVac](https://github.com/mitchellrj/eufy_robovac)
- [SpotCast](https://github.com/fondberg/spotcast)

## Additional Components:

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
