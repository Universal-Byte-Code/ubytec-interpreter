﻿namespace Ubytec.Language.Exceptions
{
    /// <summary>
    /// An exception occurred during tokenization
    /// </summary>
    /// <param name="errorCode"></param>
    /// <param name="message"></param>
    /// <param name="helpLink"></param>
    [CLSCompliant(true)]
    [method:CLSCompliant(false)]
    public class TokenizationOperationException(ulong errorCode, string message, string? helpLink = null) : UbytecException(errorCode, message, helpLink)
    {
    }
}
