#!/bin/env python

from PIL import Image
import pytesseract
import os
import boto3
import sys

#img = '/home/ubuntu/waverly_12042017_a.JPG'
bucket_name = 'grocery-receipts'
s3 = boto3.resource('s3')
bucket = s3.Bucket(bucket_name)
list_of_receipts = []

def get_list_of_receipts_from_s3(bucket):
  ''' This function gets the receipt list from the defined S3 bucket '''
  for object in bucket.objects.all():
    print(object.key)
    list_of_receipts.append(object.key)
  return(list_of_receipts)

def get_receipt_image(s3_img_key):
  filename = '/tmp/' + s3_img_key
  dl_image = s3.Object(bucket_name, s3_img_key).download_file(filename)
  print(dl_image)
  return(filename)

def rotate_img_90(img):
        rotate90=img.rotate(90)
        return rotate90
def get_text(img):
        text = pytesseract.image_to_string(Image.open(img), config='--psm 1')
	return(text)

def write_to_file(receipt, rcpt_items):
  filename = '/tmp/out_' + receipt
#  unicode_to_utf = rcpt_items.decode('utf-8')
  reload(sys)
  sys.setdefaultencoding('utf-8')
  with open(filename, 'w') as out_file:
    out_file.write(str(rcpt_items))

def main():
  receipt_list = get_list_of_receipts_from_s3(bucket)
  for receipt in receipt_list:
    # TODO: Get each receipt image
    img_name = receipt.split(".")
    print(img_name)
    print(type(img_name))
    print(str(img_name[-1]).lower())
    ext = str(img_name[-1]).lower()
    if (ext != 'jpg'):
        if (ext != 'jpeg'):
	  print(ext)
	  print('jpg')
          print("We only support jpeg type of images currently. Sorry")
    else:
      img = get_receipt_image(receipt)
      # evaluate each receipt image
      rcpt_items = get_text(img)
      print(rcpt_items)
      to_file = write_to_file(receipt, rcpt_items)
      print(type(rcpt_items))

if __name__ == "__main__":
  main()

