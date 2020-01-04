<p align="center">
  <a href="https://www.powershellgallery.com/packages/Statusimo"><img src="https://img.shields.io/powershellgallery/v/Statusimo.svg"></a>
  <a href="https://www.powershellgallery.com/packages/Statusimo"><img src="https://img.shields.io/powershellgallery/vpre/Statusimo.svg?label=powershell%20gallery%20preview&colorB=yellow"></a>
  <a href="https://github.com/EvotecIT/Statusimo"><img src="https://img.shields.io/github/license/EvotecIT/Statusimo.svg"></a>
</p>

<p align="center">
  <a href="https://www.powershellgallery.com/packages/Statusimo"><img src="https://img.shields.io/powershellgallery/p/Statusimo.svg"></a>
  <a href="https://github.com/EvotecIT/Statusimo"><img src="https://img.shields.io/github/languages/top/evotecit/Statusimo.svg"></a>
  <a href="https://github.com/EvotecIT/Statusimo"><img src="https://img.shields.io/github/languages/code-size/evotecit/Statusimo.svg"></a>
  <a href="https://www.powershellgallery.com/packages/Statusimo"><img src="https://img.shields.io/powershellgallery/dt/Statusimo.svg"></a>
</p>

<p align="center">
  <a href="https://twitter.com/PrzemyslawKlys"><img src="https://img.shields.io/twitter/follow/PrzemyslawKlys.svg?label=Twitter%20%40PrzemyslawKlys&style=social"></a>
  <a href="https://evotec.xyz/hub"><img src="https://img.shields.io/badge/Blog-evotec.xyz-2A6496.svg"></a>
  <a href="https://www.linkedin.com/in/pklys"><img src="https://img.shields.io/badge/LinkedIn-pklys-0077B5.svg?logo=LinkedIn"></a>
</p>


# Statusimo - PowerShell Module

**Statusimo** is a **PowerShell** module that is able to generate a **Status Page** entirely from **PowerShell**. There are many solutions on the market that allow you to host and build your own Status Page for services you have but usually, it comes at a cost or it has some special requirements one has to meet. Following module generates a static HTML page that contains JavaScript/CSS and HTML in one single file you can put on a server or publish using any way you want.

## Links

- [Documentation for Statusimo (module description, installation)](https://evotec.xyz/hub/scripts/Statusimo-powershell-module/) - Full project description
- [Overview of Statusimo](https://evotec.xyz/meet-statusimo-powershell-generated-status-page/) - First version overview and how-to

### Changelog

- [X] 0.5 - Not released
  - Support for new PSWriteHTML
- [x] 0.2 - 16.03.2019
  - [x] Fix for TimeZone issue being UTC (thanks Steve (borough11)
  - [x] Updates to support changes in PSWriteHTML (requires newest version of PSWriteHTML 0.0.13+)
  - [x] Small visual change to TimeLine (using Roboto font, a bit larger size)
  - [x] Cleaner HTML/JS/CSS (update to PSWriteHTML)
  - [x] Smaller output size (update to PSWriteHTML)
- [x] 0.1
  - [x] First version

### Example - Status Page

![image](https://evotec.xyz/wp-content/uploads/2019/03/img_5c7feee0d161a.png)
