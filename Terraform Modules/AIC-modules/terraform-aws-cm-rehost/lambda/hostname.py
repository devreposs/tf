import boto3
import os
client = boto3.client('ssm')
def createParameterStore(suffix):
    paramStoreValue=((os.environ['hostnameprefix']+suffix))
    response = client.put_parameter(
            Name=os.environ['parameterstorekey'],
            Description=os.environ['parameterstorekey'],
            Value=paramStoreValue,
            Type='String',
            Overwrite=True,
            )
    return paramStoreValue
def lambda_handler(event, context):
    suffixlength = int(os.environ['suffixlength']) 
    hostnameprefix = os.environ['hostnameprefix']
    hostnamelength = os.environ['hostmaxlength']
    parameterstorekey = os.environ['parameterstorekey']
    ParameterStoreValue=''
    suffixOfParameterStoreValue=1
    start=''
    end=''
    updatedParamstoreValue=''

    if (len(hostnameprefix)+suffixlength) <=int(hostnamelength):
        try:
            ParameterStoreValue = client.get_parameter(Name=parameterstorekey)
            ParameterStoreValue = ParameterStoreValue ['Parameter']['Value']
            start=len(ParameterStoreValue)-suffixlength
            end=len(ParameterStoreValue)
            suffixOfParameterStoreValue = int(ParameterStoreValue[start:end])
            print(suffixOfParameterStoreValue)
            updatedParamstoreValue=createParameterStore(str((suffixOfParameterStoreValue+1)).zfill(suffixlength))
            
        except Exception:
            updatedParamstoreValue=createParameterStore(str(suffixOfParameterStoreValue).zfill(suffixlength))
    else:
        return 'HostnamePrefix length is greater than 13 characters'
    return updatedParamstoreValue
