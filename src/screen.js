const puppeteer = require('puppeteer');
const fs = require('fs-extra');
const path = require('path');

async function screenshot(url) {
  const browser = await puppeteer.launch({
    headless: false,
    args: [
      "--no-sandbox",
      "--disable-gpu",
      "--disable-setuid-sandbox"
    ]
  });

  const page = (await browser.pages())[0];


  try {
    const override = Object.assign(page.viewport(), {width: 1024, height: 800});
    await page.setViewport(override);

    await page.goto(url, {
      waitUntil: 'networkidle0',
      timeout: 10000
    });
    const screenData = await page.screenshot({encoding: 'binary', type: 'jpeg', quality: 30});
    const filePath = path.resolve(`../dist/screenshot.jpg`);
    await fs.outputFile(filePath, screenData);
  } catch (e) {
    console.log('Site not valid', e);
  }

  // stay open in docker for browsing
  // await page.close();
  // await browser.close();
}

module.exports = screenshot;

